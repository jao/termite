class String
  def left size=80
    s = " #{self.chomp} "
    s += " "*(size - s.length) if size > s.length
    s
  end
  
  def right size=80
    s = " #{self.chomp} "
    s = " "*(size - s.length) + s if size > s.length
    s
  end
  
  def center size=80
    s = " #{self.chomp} "
    (s.length..size).each do |n|
      s = n % 2 == 0 ? " #{s}" : "#{s} "
    end
    s
  end
  
  def banner size=80
    max = size
    s = ""
    self.each_line do |l|
      l = " #{l.chomp} "
      max = l.length if l.length > max
      l += " "*(size-l.length)
      s += "#{l}\n"
    end
    el = " "*size
    if max > size
      self.banner(max, lines)
    else
      lines ? "#{el}\n#{s.chomp}\n#{el}" : s.chomp
    end
  end
  
  def tc fg, bg=nil, format=nil
    @fg = fg_color fg
    @bg = bg_color bg
    @format = set_format format
    "\e[#{@format};#{@fg};#{@bg}m#{self}\e[0m"
  end
  
  # color patterns
  def debug
    self.tc('pink')
  end
  
  def debug! format=nil
    self.tc('white','pink',format)
  end
  
  def info! format=nil
    self.tc('black','white',format)
  end
  
  def more_info! format=nil
    self.tc('blue','white',format)
  end
  
  def success
    self.tc('green')
  end
  
  def success? condition, bg=false
    bg ? self.tc(condition ? 'black' : 'white', condition ? 'green' : 'yellow') : self.tc(condition ? 'green' : 'yellow')
  end
  
  def success! format=nil
    self.tc('black','green',format)
  end
  
  def warn
    self.tc('yellow')
  end
  
  def warn! format=nil
    self.tc('black','yellow',format)
  end
  
  def error
    self.tc('red')
  end
  
  def error! format=nil
    self.tc('white','red',format)
  end
  
  protected
  # color aliases using method missing
  def method_missing methodname, *args
    colors = methodname.to_s.split('_')
    self.tc(colors[0],colors[1],colors[2])
  end
  
  def set_format fn=nil
    case fn
      when 'bold','b':      1
      when 'underline','u': 4
      when 'blink','i':     5
      when 'invert','x':    7
      else 0
    end
  end

  def fg_color cn=nil
    case cn
      when 'black':  30
      when 'red':    31
      when 'green':  32
      when 'yellow': 33
      when 'blue':   34
      when 'pink':   35
      when 'cyan':   36
      when 'white':  37
      else 37;
    end
  end

  def bg_color cn=nil
    case cn
      when 'black':  40
      when 'red':    41
      when 'green':  42
      when 'yellow': 43
      when 'blue':   44
      when 'pink':   45
      when 'cyan':   46
      when 'white':  47
      else 40;
    end
  end
end