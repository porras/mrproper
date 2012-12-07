require 'mrproper'
require 'properties_helper'

def double(i)
  i * 2
end

properties 'double' do
  data Integer
  data Float
  
  property 'is the same as adding twice' do |data|
    assert_equal data + data, double(data)
  end
end

def reverse(string)
  string.reverse
end

properties 'reverse' do
  data String
  
  property 'should reverse itself' do |data|
    assert_equal data, reverse(reverse(data))
  end
end

def sort(array)
  array.sort
end

properties 'sort' do

  data [Integer]
  data [String]
  
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

def add(a, b)
  a + b
end

properties 'add' do
  data({:a => Integer, :b => Integer, :c => Integer})
  data({:a => Float, :b => Float, :c => Float})
  
  property 'commutative' do |data|
    assert_close add(data[:a], data[:b]), add(data[:b], data[:a])
  end
  
  property 'associative' do |data|
    assert_close add(add(data[:a], data[:b]), data[:c]), add(data[:a], add(data[:b], data[:c]))
  end
  
  property 'zero' do |data|
    assert_close add(data[:a], 0), data[:a]
  end
end
