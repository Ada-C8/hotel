require 'simplecov'
SimpleCov.start

# specs/spec_helper.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require 'minitest/skip_dsl'
require 'pry'

# Require any classes
# ex require_relative 'lib/foo.rb'
require_relative '../lib/hotel.rb'
require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
