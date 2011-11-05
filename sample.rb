require 'minitest/autorun'
require 'property'

def double(i)
  i * 2
end

properties 'double' do
  data { rand(1_000_000) }
  
  property 'is the same as adding twice' do |data|
    data + data == double(data)
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
    data.size == sort(data).size
  end
  
  property 'idempotency' do |data|
    sort(data) == sort(sort(data))
  end
  
  property 'is a permutation of the original list' do |data|
    is_permutation?(data, sort(data))
  end
  
  property 'is ordered' do |data|
    is_ordered?(sort(data))
  end
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