require "simplecov"
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/hotel.rb'
require_relative '../lib/date_range.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
