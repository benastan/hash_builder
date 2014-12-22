# HashBuilder

Simple DSL for building hashes

## Installation

Add this line to your application's Gemfile:

    gem 'hash_builder', github: 'benastan/hash_builder'

And then execute:

    $ bundle

## Usage

```
require 'hash_builder'
require 'hash_builder/core_ext/hash'

Hash.build(context: { something: 'ball bearings' }) do
  someKey 'blah key'

  someArray do
    self << hash do
      arrayValue 'hash'
    end

    self << 'bar'
  end

  # To use reserved keywords, as hash keys, 
  _hash do
    foo context[:something]
  end
end
=> {:someKey=>"blah key", :someArray=>[{:arrayValue=>"hash"}, "bar"], :hash=>{:foo=>"ball bearings"}}
```

```
Hash.build(string_keys: true) do
  here 'we go'

  there do
    self << hash do
      blarr 'jar'

      # Switch to symbol keys.
      symbol_keys!
      poly 'fil'

      # Switch back to string keys.
      string_keys!
      joly 'chill'
    end
  end
end
=> {"here"=>"we go", "there"=>[{"blarr"=>"jar", :poly=>"fil", "joly"=>"chill"}]}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/hash_builder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
