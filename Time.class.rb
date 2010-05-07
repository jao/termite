class Time
  def tomorrow
    self.days
  end
  
  def days n=1
    self + 86400 * n
  end
  
  def yesterday
    self.days(-1)
  end
  
  def start_of_day
    Time.local(self.year, self.month, self.day)
  end
  
  def end_of_day
    Time.local(self.year, self.month, self.day).tomorrow - 1
  end
  
  def start_of_month
    Time.local(self.year, self.month)
  end
  
  def end_of_month
    Time.local(self.year, self.month+1) - 1
  end
end