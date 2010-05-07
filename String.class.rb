class String
  def init
    @bg ||= bg_color
    @fg ||= fg_color
    @format ||= format
  end

  def colorize fg, bg=nil, format=nil
    init
    @fg = fg_color(fg)
    @bg = bg_color(bg) unless bg.nil?
    @format = format(format) unless format.nil?
    "\e[#{@format};#{@fg};#{@bg}m#{self}\e[0m"
  end
  
  def success
    colorize('black', 'green')
  end
  
  def warning
    colorize('black','yellow')
  end
  
  def error
    colorize('white', 'red', 'bold')
  end
  
  def right size=10
    s = " #{self} "
    s = " #{s}" while s.length < size
    s
  end
  
  def left size=10
    s = " #{self} "
    s = "#{s} " while s.length < size
    s
  end
  
  def center size=60
    s = " #{self} "
    s = (s.length % 2 == 0) ? " #{s}" : "#{s} " while s.length < size
    s
  end

  def banner size=60, lines=false
    max = size
    s = ""
    self.each_line do |l|
      l = l.chomp # gsub(/\r|\n/,'')
      l = "  #{l}  "
      max = l.length if l.length > max
      l += " " while l.length <= size
      s += "#{l}\n"
    end
    lt = " "*size
    lb = " "*size
    if max > size
      s.banner max+4, lines
    else
      lines ? "\n#{lt}\n#{s.chomp}\n#{lb}" : "#{s.chomp}"
    end
  end

  protected
  def format mode=nil
    case mode
      when 'bold','b':      1
      when 'underline','u': 4
      when 'blink','i':     5
      when 'invert','x':    7
      else 0
    end
  end

  def fg_color color=nil
    case color
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

  def bg_color color=nil
    case color
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