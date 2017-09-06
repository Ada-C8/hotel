require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/reporters'
require 'date'


require 'simplecov'
SimpleCov.start

#require any classes
require_relative '../lib/date_range'



Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
