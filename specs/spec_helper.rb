require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/hotel.rb'
require_relative '../lib/reservations.rb'
require_relative '../lib/rooms.rb'
