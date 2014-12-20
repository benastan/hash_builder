require "hash_builder/version"

class HashBuilder < Hash
  attr_reader :context

  def initialize(parent = nil, key = nil, options = nil)
    options ||= {}
    @parent = parent
    @key = key
    @context = context
    @array = false
    @string_keys = options[:string_keys]
    @context = options[:context]
  end

  def string_keys!
    @string_keys = true
  end

  def symbol_keys!
    @string_keys = false
  end

  def method_missing(method, *args, &block)
    if method[0] == '_'
      method = method[1..-1].to_sym
    end

    if @string_keys
      method = method.to_s
    end

    if args.any?
      self[method] = args.first
    elsif block_given?
      self[method] = HashBuilder.new(self, method, options)
      self[method].instance_exec(&block)
    else
      super
    end

    self
  end

  def options
    { string_keys: @string_keys, context: @context }
  end

  def hash(&block)
    Hash.build(options, &block)
  end

  def <<(item)
    unless @array
      @parent[@key] = []
      @array = true
    end

    @parent[@key] << item
  end
end
