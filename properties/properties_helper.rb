module PropertiesHelper
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
  
  def assert_close(a, b, delta = 0.000000001)
    assert (a - b).abs < delta
  end
end

include PropertiesHelper
