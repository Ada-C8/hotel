require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'



# Require any classes
# ex require_relative 'lib/foo.rb'
require_relative '../lib/hotel.rb'
require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
