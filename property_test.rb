require 'minitest/autorun'
require 'property'

class DSLTest < MiniTest::Unit::TestCase
  
  def setup
    Property::DSL.send :public, :data_block
    @pb = Property::DSL.new
  end
  
  def test_data_block_with_block
    b = @pb.data_block { :wadus }
    assert_kind_of Proc, b
    assert_equal :wadus, b.call
  end
  
  def test_data_block_with_a_fixed_value
    b = @pb.data_block 1
    assert_kind_of Proc, b
    assert_equal 1, b.call
  end
  
  def test_data_block_with_nil
    b = @pb.data_block nil
    assert_kind_of Proc, b
    assert_nil b.call
  end
  
  def test_data_block_with_nil_class
    b = @pb.data_block NilClass
    assert_kind_of Proc, b
    assert_nil b.call
  end
  
  def test_data_block_with_single_integer
    b = @pb.data_block Integer
    assert_kind_of Proc, b
    assert_kind_of Integer, b.call
    assert_changes { b.call }
  end
  
  def test_data_block_with_single_float
    b = @pb.data_block Float
    assert_kind_of Proc, b
    assert_kind_of Float, b.call
    assert_changes { b.call }
  end
  
  def test_data_block_with_single_string
    b = @pb.data_block String
    assert_kind_of Proc, b
    assert_kind_of String, b.call
    assert_changes { b.call }
  end
  
  def test_data_block_with_single_symbol
    b = @pb.data_block Symbol
    assert_kind_of Proc, b
    assert_kind_of Symbol, b.call
    assert_changes { b.call }
  end
  
  def test_data_block_with_array_of_strings
    b = @pb.data_block [String]
    assert_kind_of Proc, b
    assert_kind_of Array, b.call
    b.call.each do |item|
      assert_kind_of String, item
    end
    assert_changes { b.call.size }
  end
  
  def test_data_block_with_array_of_integers
    b = @pb.data_block [Integer]
    assert_kind_of Proc, b
    assert_kind_of Array, b.call
    b.call.each do |item|
      assert_kind_of Integer, item
    end
    assert_changes { b.call.size }
  end
  
  def test_data_block_with_array_of_arrays_of_integers
    b = @pb.data_block [[Integer]]
    assert_kind_of Proc, b
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
    b = @pb.data_block [Integer, String]
    assert_kind_of Proc, b
    assert_kind_of Array, b.call
    assert_equal 2, b.call.size
    assert_kind_of Integer, b.call[0]
    assert_kind_of String, b.call[1]
    assert_changes { b.call }
  end
  
  def test_data_block_with_hash_of_symbol_to_string
    b = @pb.data_block({ Symbol => String })
    assert_kind_of Proc, b
    assert_kind_of Hash, b.call
    b.call.each do |k, v|
      assert_kind_of Symbol, k
      assert_kind_of String, v
    end
    assert_changes { b.call.size }
  end
  
  def test_data_block_with_hash_of_symbol_to_array_of_strings
    b = @pb.data_block({ Symbol => [String] })
    assert_kind_of Proc, b
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
  
  private
  
  def assert_changes(&block)
    assert 10.times.map(&block).uniq.size > 1
  end
  
end
