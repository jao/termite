class Time
  def tomorrow
    self.days(1)
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
  
  def ftime f='time'
    case f
      when 'date': self.strftime("%d/%m/%Y")
      when 'datetime': self.strftime("%d/%m/%Y %H:%M")
      when 'datetimesec': self.strftime("%d/%m/%Y %H:%M %S'")
      when 'iso': self.strftime("%Y-%m-%d %H:%M")
      when 'time': self.strftime("%H:%M")
      when 'wday': self.strftime("%a")
      when 'wdaydate': self.strftime("%a %d/%m")
      when 'daymonth': self.strftime("%d/%m")
      when 'monthyear': self.strftime("%B %Y")
    end  
  end
end