require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/Room'
require_relative '../lib/Reservation'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
