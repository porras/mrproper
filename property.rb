module Property
  
  TESTS_PER_PROPERTY = 100
  
  module DSL
    def properties(name, &block)
      properties_block = PropertiesBlock.new
      properties_block.instance_eval(&block)
      Class.new(MiniTest::Unit::TestCase).class_eval do
        properties_block.each do |message, test_block, data|
          define_method "test_property: #{message.inspect} with #{data.inspect}" do
            begin
              instance_exec(data, &test_block)
            rescue MiniTest::Assertion => e
              raise MiniTest::Assertion.new("Property #{message.inspect} is falsable for data #{data.inspect}\n#{e.message}")
            end
          end
        end
      end
    end
  end
  
  class PropertiesBlock
    
    def initialize
      @properties = []
      @data_blocks = []
    end
    
    def data(&block)
      @data_blocks << block
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
    
  end
end

include Property::DSL
