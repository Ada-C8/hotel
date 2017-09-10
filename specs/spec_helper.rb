require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/rooms.rb'
require_relative '../lib/hotel.rb'
require_relative '../lib/reservations.rb'
require_relative '../lib/block.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
