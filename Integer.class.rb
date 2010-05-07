class Integer
  def factorial
    return 1 if self == 0
    (1..self).inject { |i,j| i*j }
  end
  
  def tries options = {}, &block
    return if self < 1
    yield attempts ||= 1
    rescue options[:ignoring] || Exception
    retry if (attempts += 1) <= self
  end
  
  def to_t
    Time.at(self)
  end
end