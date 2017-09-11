require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/reservation'
require_relative '../lib/date_range'
require_relative '../lib/room'
require_relative '../lib/invalid_room_error'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
