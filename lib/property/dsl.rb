module Property
  
  TESTS_PER_PROPERTY = 100
  
  class DSL
    
    def initialize
      @properties = []
      @data_blocks = []
    end
    
    def data(spec = nil, &block)
      @data_blocks << data_block(spec, &block)
    end
    
    def property(message, &block)
      @properties << [message, block]
    end
    
    def each(&block)
      @properties.each do |message, test_block|
        @data_blocks.each do |data_block|
          TESTS_PER_PROPERTY.times do
            block.call(message, test_block, data_block.call)
          end
        end
      end
    end
    
    private
    
    def data_block(spec = nil, &block)
      return block if block_given?
      
      case spec
      when Array
        if spec.size == 1
          Proc.new { rand(20).times.map { data_block(spec.first).call } }
        else
          Proc.new { spec.map { |spec| data_block(spec).call }}
        end
      when Hash
        Proc.new do
          {}.tap do |h|
            rand(20).times.each do
              h[data_block(spec.keys.first).call] = data_block(spec.values.first).call
            end
          end
        end
      when Class
        if spec == Integer
          Proc.new { rand(1000) - 500 }
        elsif spec == Float
          Proc.new { rand * 10 - 10 }
        elsif spec == String
          Proc.new { String.random(rand(10)) }
        elsif spec == Symbol
          Proc.new { data_block(String).call.to_sym }
        elsif spec == NilClass
          Proc.new { nil }
        end
      else
        Proc.new { spec }
      end
    end
    
  end
  
end