# RedAmber

Simple dataframe library for Ruby

- Powered by Red Arrow
- Rover-df like simple API

## Requirements

```ruby
gem 'red-arrow',   '~> 7.0.0'
gem 'red-parquet', '~> 7.0.0' # if you use IO from/to parquet
gem 'rover-df',    '~> 0.3.0' # if you use IO from/to Rover::DataFrame
```

## Installation

Add this line to your Gemfile:

```ruby
gem 'red_amber'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install red_amber

## `RedAmber::DataFrame`

### Constructors

- [x] `new` from a Hash
  - `RedAmber::DataFrame.new(hash)`

- [x] `new` from an Array

- [ ] `new` from a Rover::DataFrame

- [ ] `load` from a file (csv, parquet, etc.)

### Properties
- [x] `shape`
 
  Show shape in an Array[n_rows, n_cols]
 
- [x] `n_rows`, `nrow`, `size`, `length`
  
  Show num of rows (data size)
 
- [x] `n_columns`, `ncol`, `width`
  
  Show num of columns (num of vectors).
 
- [x] `column_names`, `keys`
  
  Return num of keys by an Array

- [x] `vectors`

  Return an Array of Vector.

- [x] `empty?`
 
- [x] `types(class_name: false)`
  
  Return types of columns by an Array.
  If `class_name: true` return Array of DataType.
 
- [x] `inspect(tally_level: 5, max_element: 5)`

  Show information about DataFrame.

  - tally_level: max level to use tally mode
  - max_element: max num of element to show values in each row

- [x] `to_s`

- [ ] summary, describe

### Output

- [x] `to_h`
  
- [x] `to_a`

- [x] `raw_records`

  Return an array of rows without header

- [ ] to_rover

- [ ] to_csv

- [ ] to_parquet

### Selecting
- [x] Selecting columns by `[]`

  [key], [keys], [keys[index]]]

- [x] Selecting rows

  `head(n=5)`, `tail(n=5)`, `first(n=1)`, `last(n=1)`

- [x] Selecting rows by `[]`

  [index], [range], [array]

- [ ] slice

### Updating

- [ ] Add a new column

- [ ] Update a single element

- [ ] Update multiple elements

- [ ] Update all elements

- [ ] Update elements matching a condition

- [ ] Clamp

- [ ] Delete columns

- [ ] Rename a column

- [ ] Sort rows

- [ ] Clear data

### Treat na data

- [ ] Drop na (NaN, nil)

- [ ] Replace na with value

- [ ] Interpolate na with convolution array

### Combining DataFrames

- [ ] Add rows

- [ ] Add columns

- [ ] Inner join

- [ ] Left join

### Encoding

- [ ] One-hot encoding

### Iteration (not impremented)

### Filtering (not impremented)


## `RedAmber::Vector`
### Constructor

- [x] Create from columns in a DataFrame

- [x] new from an Array

### Properties

- [x] to_s

- [x] values, to_a, entries

- [x] size, length, n_rows, nrow

- [x] type

- [ ] each

- [ ] chunked?

- [ ] n_chunks

- [ ] each_chunk

- [x] tally

- [ ] n_nulls

### Operations
#### Unary
- [ ] !, -@

#### Binary
- [ ] +, - , *, /, %, **
- [ ] ==, !=, >, >=, <, <=, eq, ne, gt, ge, lt, le

#### Functions
- [ ] abs, sum, prod, sort, sort_index
- [ ] min, max, minmax, mean, stddev, var, median, quantile
- [ ] argmin, argmax

### Updating (not impremented)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test-unit` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
