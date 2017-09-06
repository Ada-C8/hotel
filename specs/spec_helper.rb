require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/hotel'
#require_relative 'lib/room'
#require_relative 'lib/reservation'
#require_relative 'lib/daterange'

require 'simplecov'
SimpleCov.start


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
