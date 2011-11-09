module MrProper
  class FalsableProperty < Exception; end
end

unless Test::Unit.const_defined?('AssertionFailedError')
  class Test::Unit::AssertionFailedError < Exception; end
end

unless Object.const_defined?('MiniTest')
  module MiniTest
    class Assertion < Exception; end
  end
end