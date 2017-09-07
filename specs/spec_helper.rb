require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/reporters'
require 'date'


require 'simplecov'
SimpleCov.start

#require any classes
require_relative '../lib/date_range'
require_relative '../lib/reservation'
require_relative '../lib/room'
require_relative '../lib/booking_system'



Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
