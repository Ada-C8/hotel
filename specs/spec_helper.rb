require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/rooms.rb'
require_relative '../lib/hotel.rb'
require_relative '../lib/availability.rb'
require_relative '../lib/reservations.rb'
require_relative '../lib/blocks.rb'



Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
