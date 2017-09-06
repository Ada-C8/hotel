require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/room'
# require_relative '../lib/'
# require_relative '../lib/'






Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
