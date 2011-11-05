require 'minitest/autorun'
require 'properties_helper'

class TestIsOrdered < MiniTest::Unit::TestCase
  
  include PropertiesHelper
  
  def test_empty
    assert is_ordered?([])
  end
  
  def test_one
    assert is_ordered?([1])
  end
  
  def test_two
    assert is_ordered?([1, 2])
  end
  
  def test_two_disordered
    assert !is_ordered?([2, 1])
  end
  
  def test_repeated
    assert is_ordered?([1, 2, 2, 2, 3])
  end
  
end