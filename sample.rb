require 'minitest/autorun'
require 'test_helper'
require 'property'

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
