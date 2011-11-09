module MrProper
  
  class DataBlock
    
    EXAMPLES_PER_PROPERTY = 200
    
    def initialize(spec = nil, &block)
      @spec = spec
      @block = block
    end
    
    def data
      EXAMPLES_PER_PROPERTY.times.map { call }.uniq
    end
    
    def call
      to_proc.call
    end
    
    def to_proc
      return @block if @block
      
      case @spec
      when Array
        if @spec.size == 1
          Proc.new { rand(20).times.map { DataBlock.new(@spec.first).call } }
        else
          Proc.new { @spec.map { |s| DataBlock.new(s).call }}
        end
      when Hash
        if @spec.size == 1
          Proc.new do
            {}.tap do |h|
              rand(20).times.each do
                h[DataBlock.new(@spec.keys.first).call] = DataBlock.new(@spec.values.first).call
              end
            end
          end
        else
          Proc.new do
            {}.tap do |h|
              @spec.each do |k, v|
                h[DataBlock.new(k).call] = DataBlock.new(v).call
              end
            end
          end
        end
      when Class
        if @spec == Integer
          Proc.new { rand(1000) - 500 }
        elsif @spec == Float
          Proc.new { rand * 10 - 10 }
        elsif @spec == String
          Proc.new { String.random(rand(10)) }
        elsif @spec == Symbol
          Proc.new { DataBlock.new(String).call.to_sym }
        elsif @spec == NilClass
          Proc.new { nil }
        end
      else
        Proc.new { @spec }
      end
    end
    
  end
  
end