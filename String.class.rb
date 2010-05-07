class String
  def init
    @bg ||= bg_color
    @fg ||= fg_color
    @format ||= format
  end

  def tc fg, bg=nil, format=nil
    init
    @fg = fg_color(fg)
    @bg = bg_color(bg) unless bg.nil?
    @format = format(format) unless format.nil?
    "\e[#{@format};#{@fg};#{@bg}m#{self}\e[0m"
  end
  
  def success
    tc('black', 'green')
  end
  
  def warning
    tc('black','yellow')
  end
  
  def error
    tc('white', 'red', 'b')
  end
  
  def right n=10
    s = " #{self.strip} "
    s = " "+s while s.length < n
    s
  end
  
  def left n=10
    s = " #{self.strip} "
    s += " " while s.length < n
    s
  end
  
  def center n=60
    s = " #{self.strip} "
    s = (s.length % 2 == 0) ? " "+s : s+" " while s.length < n
    s
  end

  def banner n=60, sl=false
    max = n
    s = ""
    self.each_line do |l|
      l = l.strip.chomp
      l = "  #{l}  "
      max = l.length if l.length > max
      l += " " while l.length < n
      s += "#{l}\n"
    end
    la = lb = " "*n
    if max > n
      s.banner max+4, sl
    else
      sl ? "\n#{lb}\n#{s.chomp}\n#{la}" : "#{s.chomp}"
    end
  end

  protected
  def format fn=nil
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