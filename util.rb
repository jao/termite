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