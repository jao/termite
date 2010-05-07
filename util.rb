#/usr/bin/env ruby
require 'String.class.rb'
require 'Integer.class.rb'
require 'Time.class.rb'
require 'rubygems'
require 'highline'
require 'highline/system_extensions'

# get terminal window resolution
WINDOW = HighLine::SystemExtensions.terminal_size

# print in the same line
def printi s
  print "\r#{s}#{' '*(WINDOW[0]-s.size)}"
end

# banner
def banner s,size=60,fg=37,bg=41
  result  = "\e[0;#{fg};#{bg}m"+(" "*size)+"\n"
  s.each_line do |line|
    line.strip!
    while line.size < size do
      line = line.size%2==0 ? "#{line} " : " #{line}"
    end
    result += line+"\n"
  end
  result += (" "*size)+"\e[0m\n"
  return result+"\n"
end

# text animation
@animation_counter = {}
def text_animation t
  frames = case t
    when 'bars',1; ['/','-','\\','|']
    when 'gym', 2; ['_o_','\\o/','|o|','\\o/']
    else           ['.',' ']
  end
  
  @animation_counter[t] = 1 if @animation_counter[t].nil?
  s = frames[@animation_counter[t]%frames.size]
  @animation_counter[t] += 1
  return s
end

def bars; text_animation 'bars';end
def gym; text_animation 'gym'; end

def percentage_bar current, total
  bar = "|"
  bar += "="*((current*100/total)/2)
  bar += ">"
  while bar.size < 52
    bar += " "
  end
  bar += "|"
  return "#{bar} #{current}/#{total} #{(" " + sprintf("%.2f",current.to_f*100/total) + "% ").invert.bold}"
end

trap("INT") {
  print "\n\n"
  exit 0
}