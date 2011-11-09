module MrProper
  
  def properties(name, &block)
    dsl = MrProper::DSL.new
    dsl.instance_eval(&block)
    Class.new(Test::Unit::TestCase).class_eval do
      eval("def self.name; #{name.inspect}; end")
      dsl.properties.each do |message, test_block|
        define_method "test_property: #{message.inspect}" do
          dsl.data_blocks.each do |data_block|
            TESTS_PER_PROPERTY.times do
              data = data_block.call
              begin
                instance_exec(data, &test_block)
              rescue Test::Unit::AssertionFailedError, MiniTest::Assertion => e
                raise FalsableProperty.new("Property #{message.inspect} is falsable for data #{data.inspect}\n#{e.message}")
              end
            end
          end
        end
      end
    end
  end
  
end
