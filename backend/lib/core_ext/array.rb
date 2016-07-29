class Array
  def pad_with(elem)
    return [] if self.size == 0
    self[0..-2].reduce([]) { |arr, obj| arr.push(obj, elem) }.push(self[-1])
  end
end
