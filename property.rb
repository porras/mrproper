module Property
  
  TESTS_PER_PROPERTY = 100
  
  module DSL
    def properties(name, &block)
      properties_block = PropertiesBlock.new
      properties_block.instance_eval(&block)
      Class.new(MiniTest::Unit::TestCase).class_eval do
        properties_block.properties.each do |message, block|
          TESTS_PER_PROPERTY.times do |i|
            define_method "test_#{message} (#{i})" do
              instance_exec do
                data = properties_block.data_block.call
                assert block.call(data), "Property '#{message}' is false with data #{data.inspect}"
              end
            end
          end
        end
      end
    end
  end
  
  class PropertiesBlock
    attr_reader :properties, :data_block
    
    def initialize
      @properties = []
    end
    
    def data(&block)
      @data_block = block
    end
    
    def property(message, &block)
      @properties << [message, block]
    end
  end
end

include Property::DSL
