#/usr/bin/env ruby
require 'String.class.rb'
require 'Integer.class.rb'
require 'Time.class.rb'
require 'rubygems'

STDOUT.sync = true

trap("INT"){
  print "\n\n"
  exit
}

# color picking function
def cpick *args
  args = args.extract_options!
  time = Time.at args[:date]
  return 'cyan' if time.weekend?
  return 'blue' if time.holiday?
  case args[:status]
    when 'sick': 'pink'
    when 'start'
      ('white' if time.hour == TIME_CONFIG[:start]) ||
      ('green' if time.hour == TIME_CONFIG[:start]+1) ||
      ('yellow' if time.hour == TIME_CONFIG[:start]+2) ||
      'red'
    when 'stop'
      ('white' if time.hour == TIME_CONFIG[:end]) ||
      ('green' if time.hour == TIME_CONFIG[:end]+1) ||
      ('yellow' if time.hour == TIME_CONFIG[:end]+2) ||
      'red'
    when 'lunch'
      ('white' if time.hour == 13) ||
      ('green' if time.hour == 14) ||
      ('yellow' if time.hour == 15) ||
      'red'
    when 'back'
      ('white' if time.hour == 14) ||
      ('green' if time.hour == 15) ||
      ('yellow' if time.hour == 16) ||
      'red'
    when 'lunch_duration'
      ('white' if time.hour < 1 && time.min <= 15) ||
      ('green' if time.hour < 1 && time.min > 15) ||
      ('yellow' if time.hour == 1 && time.min < 15) ||
      'red'
    when 'total'
      ('white' if time.hour == TIME_CONFIG[:workday] && time.min <= 30) ||
      ('green' if time.hour == TIME_CONFIG[:workday]+1 || (time.hour == TIME_CONFIG[:workday] && time.min >= 30)) ||
      ('yellow' if time.hour == TIME_CONFIG[:workday]+2 || time.hour < TIME_CONFIG[:workday]) ||
      'red'
    else 'white'
  end
end

def set_adium_status status, msg=''
  return if !ADIUM || status == ''
  `osascript -e 'tell application "Adium" to go #{status} #{'with message "'+ msg +'"' if msg != ''}' 2>/dev/null`
end

def show_status n
  @row ||= Entry.last
  if !@row.nil?
    "#{@row.status_message} since #{@row.datetime} ~ #{Time.now.datetimesec}".left(n).black_green_bold
  else
    "Please use 'termite start' to initialize the database.".left(n).black_yellow_bold
  end
end
