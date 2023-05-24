# frozen_string_literal: true

module RedAmber
  # Mix-in for class Vector
  #   Methods for string-like related function
  module VectorStringFunction
    using RefineArray
    using RefineArrayLike

    # For each string in self, emit true if it contains a given pattern.
    #
    # @overload match_substring?(string, ignore_case: nil)
    #   Emit true if it contains `string`.
    #
    #   @param string [String]
    #     string pattern to match.
    #   @param ignore_case [boolean]
    #     switch whether to ignore case. Ignore case if true.
    #   @return [Vector]
    #     boolean Vector to show if elements contain a given pattern.
    #     nil inputs emit nil.
    #   @example Match with string.
    #     vector = Vector.new('array', 'Arrow', 'carrot', nil, 'window')
    #     vector.match_substring?('arr')
    #     # =>
    #     #<RedAmber::Vector(:boolean, size=5):0x000000000005a208>
    #     [true, false, true, nil, false]
    #
    # @overload match_substring?(regexp, ignore_case: nil)
    #   Emit true if it contains substring matching with `regexp``.
    #   It calls `match_substring_regex` in Arrow compute function and
    #   uses re2 library.
    #
    #   @param regexp [Regexp]
    #     regular expression pattern to match. Ruby's Regexp is given and
    #     it will passed to Arrow's kernel by its source.
    #   @param ignore_case [boolean]
    #     switch whether to ignore case. Ignore case if true.
    #     When `ignore_case` is false, casefolding option in regexp is priortized.
    #   @return [Vector]
    #     boolean Vector to show if elements contain a given pattern.
    #     nil inputs emit nil.
    #   @example Match with regexp.
    #     vector.match_substring?(/arr/)
    #     # =>
    #     #<RedAmber::Vector(:boolean, size=5):0x0000000000014b68>
    #     [true, false, true, nil, false]
    #
    # @since 0.5.0
    #
    def match_substring?(pattern, ignore_case: nil)
      options = Arrow::MatchSubstringOptions.new
      datum =
        case pattern
        when String
          options.ignore_case = (ignore_case || false)
          options.pattern = pattern
          find(:match_substring).execute([data], options)
        when Regexp
          options.ignore_case = (pattern.casefold? || ignore_case || false)
          options.pattern = pattern.source
          find(:match_substring_regex).execute([data], options)
        else
          message =
            "pattern must be either String or Regexp: #{pattern.inspect}"
          raise VectorArgumentError, message
        end
      Vector.create(datum.value)
    end

    # Check if elements in self end with a literal pattern.
    #
    # @param string [String]
    #   string pattern to match.
    # @param ignore_case [boolean]
    #   switch whether to ignore case. Ignore case if true.
    # @return [Vector]
    #   boolean Vector to show if elements end with a given pattern.
    #   nil inputs emit nil.
    # @example Check if end with?.
    #   vector = Vector.new('array', 'Arrow', 'carrot', nil, 'window')
    #   vector.end_with?('ow')
    #   # =>
    #   #<RedAmber::Vector(:boolean, size=5):0x00000000000108ec>
    #   [false, true, false, nil, true]
    # @since 0.5.0
    #
    def end_with?(string, ignore_case: nil)
      options = Arrow::MatchSubstringOptions.new
      options.ignore_case = (ignore_case || false)
      options.pattern = string
      datum = find(:ends_with).execute([data], options)
      Vector.create(datum.value)
    end

    # Check if elements in self start with a literal pattern.
    #
    # @param string [String]
    #   string pattern to match.
    # @param ignore_case [boolean]
    #   switch whether to ignore case. Ignore case if true.
    # @return [Vector]
    #   boolean Vector to show if elements start with a given pattern.
    #   nil inputs emit nil.
    # @example Check if start with?.
    #   vector = Vector.new('array', 'Arrow', 'carrot', nil, 'window')
    #   vector.start_with?('ow')
    #   # =>
    #   #<RedAmber::Vector(:boolean, size=5):0x00000000000193fc>
    #   [false, false, true, nil, false]
    # @since 0.5.0
    #
    def start_with?(string, ignore_case: nil)
      options = Arrow::MatchSubstringOptions.new
      options.ignore_case = (ignore_case || false)
      options.pattern = string
      datum = find(:starts_with).execute([data], options)
      Vector.create(datum.value)
    end
  end
end
