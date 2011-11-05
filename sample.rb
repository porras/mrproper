require 'minitest/autorun'
require 'property'

def double(i)
  i * 2
end

properties 'double' do
  data { rand(1_000_000) }
  
  property 'is the same as adding twice' do |data|
    assert_equal data + data, double(data)
  end
end

def sort(array)
  array.sort
end

properties 'sort' do
  data do
    (0..rand(100)).map { rand(1_000_000) }
  end

  property 'has the same size' do |data|
    assert_equal data.size, sort(data).size
  end
  
  property 'idempotency' do |data|
    assert_equal sort(data), sort(sort(data))
  end
  
  property 'is a permutation of the original list' do |data|
    assert_permutation data, sort(data)
  end
  
  property 'is ordered' do |data|
    assert_ordered sort(data)
  end
end

def assert_ordered(array)
  assert is_ordered?(array), "Expected #{array.inspect} to be ordered"
end

def assert_permutation(array1, array2)
  assert is_permutation?(array1, array2), "Expected #{array1.inspect} to be a permutation of #{array2.inspect}"
end

def is_ordered?(array)
  return true if array.size <= 1
  array[0] <= array[1] && is_ordered?(array[2..-1])
end

def is_permutation?(array1, array2)
  array2 = array2.dup
  array1.all? do |item|
    array2.delete_at(array2.index(item))
  end && array2.empty?
end

class TestIsOrdered < MiniTest::Unit::TestCase
  
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
