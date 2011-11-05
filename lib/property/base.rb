module Property
  
  def properties(name, &block)
    dsl = Property::DSL.new
    dsl.instance_eval(&block)
    Class.new(MiniTest::Unit::TestCase).class_eval do
      include PropertiesHelper if const_defined?(:PropertiesHelper)
      dsl.each do |message, test_block, data|
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
