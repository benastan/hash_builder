require 'hash_builder'

class Hash
  def self.build(options = nil, &block)
    hash = HashBuilder.new(nil, nil, options)
    hash.instance_exec(&block)
    hash
  end
end
