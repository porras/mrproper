module TestHelper
  def assert_changes(&block)
    assert 10.times.map(&block).uniq.size > 1
  end
end