#/usr/bin/env ruby

require 'String.class.rb'
require 'Integer.class.rb'
require 'Time.class.rb'
require 'rubygems'

trap("INT") {
  print "\n\n"
  exit 0
}