module Property
  
  def properties(name, &block)
    dsl = Property::DSL.new
    dsl.instance_eval(&block)
    Class.new(MiniTest::Unit::TestCase).class_eval do
      include PropertiesHelper if const_defined?(:PropertiesHelper)
      dsl.properties.each do |message, test_block|
        define_method "test_property: #{message.inspect}" do
          dsl.data_blocks.each do |data_block|
            TESTS_PER_PROPERTY.times do
              data = data_block.call
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
  end
  
end
