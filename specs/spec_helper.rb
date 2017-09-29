require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/room'
require_relative '../lib/reservation'
require_relative '../lib/hotel'
require_relative '../lib/custom_errors'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
