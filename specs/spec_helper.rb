require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/room'
require_relative '../lib/hotel'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
