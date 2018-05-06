module TestHelper
  def assert_changes(&block)
    assert 10.times.map(&block).uniq.size > 1
  end

  def assert_in_range(number, range)
    assert range.include?(number), "Expected #{number} to be within #{range.inspect}"
  end
end
