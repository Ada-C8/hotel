require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/room'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
