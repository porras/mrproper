module Property
  
  TESTS_PER_PROPERTY = 100
  
  module DSL
    def properties(name, &block)
      properties_block = PropertiesBlock.new
      properties_block.instance_eval(&block)
      Class.new(MiniTest::Unit::TestCase).class_eval do
        properties_block.properties.each do |message, block|
          properties_block.data_blocks.each do |data_block|
            TESTS_PER_PROPERTY.times do |i|
              define_method "test_#{message} (#{data_block.object_id}/#{i})" do
                data = data_block.call
                begin
                  instance_exec(data, &block)
                rescue MiniTest::Assertion => e
                  raise MiniTest::Assertion.new("Property #{message.inspect} is falsable for data #{data.inspect}\n#{e.message}")
                end
              end
            end
          end
        end
      end
    end
  end
  
  class PropertiesBlock
    attr_reader :properties, :data_blocks
    
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
  end
end

include Property::DSL
