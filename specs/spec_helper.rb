require 'simplecov'
SimpleCov.start
require 'csv'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
