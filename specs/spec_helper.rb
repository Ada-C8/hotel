require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/Booking'
require_relative '../lib/Reservation'
require_relative '../lib/Room'
require_relative '../lib/Guest'
require_relative '../lib/Block'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
