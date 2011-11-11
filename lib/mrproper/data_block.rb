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
      when Range
        case @spec.begin
        when Integer
          Proc.new { @spec.begin + rand(@spec.end - @spec.begin) }
        when Float
          Proc.new { @spec.begin + rand * (@spec.end - @spec.begin) }
        else
          Proc.new { @spec }
        end
      when Class
        if @spec == Integer
          DataBlock.new(-500..500).to_proc
        elsif @spec == Float
          DataBlock.new(-5.0..5.0).to_proc
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