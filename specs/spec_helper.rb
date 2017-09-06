# specs/spec_helper.rb
require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

#Require any classes
require_relative '../lib/hotel.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/date_range.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
