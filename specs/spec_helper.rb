require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require_relative '../lib/hotel-room.rb'
require_relative '../lib/hotel-reservation.rb'



Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
