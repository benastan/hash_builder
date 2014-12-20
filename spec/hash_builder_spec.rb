require 'bundler'
Bundler.require
require 'hash_builder'
require 'hash_builder/core_ext/hash'

describe HashBuilder do
  subject do
    Hash.build(context: { something: 'ball bearings' }) do
      someKey 'blah key'

      someArray do
        self << hash do
          arrayValue 'hash'
        end

        self << 'bar'
      end

      _hash do
        foo context[:something]
      end
    end
  end

  specify do
    expect(subject).to eq({
      someKey: 'blah key',
      someArray: [ { arrayValue: 'hash' }, 'bar' ],
      hash: {
        foo: 'ball bearings'
      }
    })
  end

  context 'when @string_keys is true' do
    subject do
      Hash.build(string_keys: true) do
        here 'we go'

        there do
          self << hash do
            blarr 'jar'

            symbol_keys!
            poly 'fil'

            string_keys!
            joly 'chill'
          end
        end
      end
    end

    specify do
      expect(subject).to eq({
        'here' => 'we go',
        'there' => [
          { 'blarr' => 'jar', :poly => 'fil', 'joly' => 'chill' }
        ]
      })
    end
  end
end
