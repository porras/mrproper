require 'test/unit'
require 'test_helper'
require 'mrproper'

class DataBlockTest < Test::Unit::TestCase
  
  include TestHelper
  
  def test_data_block_with_block
    b = MrProper::DataBlock.new { :wadus }
    
    assert_equal :wadus, b.call
  end
  
  def test_data_block_with_a_fixed_value
    b = MrProper::DataBlock.new 1
    
    assert_equal 1, b.call
  end
  
  def test_data_block_with_nil
    b = MrProper::DataBlock.new nil
    
    assert_nil b.call
  end
  
  def test_data_block_with_nil_class
    b = MrProper::DataBlock.new NilClass
    
    assert_nil b.call
  end
  
  def test_data_block_with_single_integer
    b = MrProper::DataBlock.new Integer
    
    assert_kind_of Integer, b.call
    assert_changes { b.call }
  end
  
  def test_data_block_with_single_float
    b = MrProper::DataBlock.new Float
    
    assert_kind_of Float, b.call
    assert_changes { b.call }
  end
  
  def test_data_block_with_single_string
    b = MrProper::DataBlock.new String
    
    assert_kind_of String, b.call
    assert_changes { b.call }
  end
  
  def test_data_block_with_single_symbol
    b = MrProper::DataBlock.new Symbol
    
    assert_kind_of Symbol, b.call
    assert_changes { b.call }
  end
  
  def test_data_block_with_array_of_strings
    b = MrProper::DataBlock.new [String]
    
    assert_kind_of Array, b.call
    b.call.each do |item|
      assert_kind_of String, item
    end
    assert_changes { b.call.size }
  end
  
  def test_data_block_with_array_of_integers
    b = MrProper::DataBlock.new [Integer]
    
    assert_kind_of Array, b.call
    b.call.each do |item|
      assert_kind_of Integer, item
    end
    assert_changes { b.call.size }
  end
  
  def test_data_block_with_array_of_arrays_of_integers
    b = MrProper::DataBlock.new [[Integer]]
    
    assert_kind_of Array, b.call
    b.call.each do |item|
      assert_kind_of Array, item
      item.each do |item|
        assert_kind_of Integer, item
      end
    end
    assert_changes { b.call.size }
  end
  
  def test_data_block_with_fixed_array_of_an_integer_and_a_string
    b = MrProper::DataBlock.new [Integer, String]
    
    assert_kind_of Array, b.call
    assert_equal 2, b.call.size
    assert_kind_of Integer, b.call[0]
    assert_kind_of String, b.call[1]
    assert_changes { b.call }
  end
  
  def test_data_block_with_hash_of_symbol_to_string
    b = MrProper::DataBlock.new({ Symbol => String })
    
    assert_kind_of Hash, b.call
    b.call.each do |k, v|
      assert_kind_of Symbol, k
      assert_kind_of String, v
    end
    assert_changes { b.call.size }
  end
  
  def test_data_block_with_hash_of_symbol_to_array_of_strings
    b = MrProper::DataBlock.new({ Symbol => [String] })
    
    assert_kind_of Hash, b.call
    b.call.each do |k, v|
      assert_kind_of Symbol, k
      assert_kind_of Array, v
      v.each do |item|
        assert_kind_of String, item
      end
    end
    assert_changes { b.call.size }
  end
  
  def test_data_block_with_hash_of_two_elements
    b = MrProper::DataBlock.new({:first => Integer, :second => Float})
    
    assert_kind_of Hash, b.call
    assert_equal 2, b.call.size
    assert_kind_of Integer, b.call[:first]
    assert_kind_of Float, b.call[:second]
    assert_changes { b.call[:first] }
    assert_changes { b.call[:second] }
  end
  
end
