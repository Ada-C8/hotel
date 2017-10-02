require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'date'
require_relative '../lib/reservation'
require_relative '../lib/hotel'
require_relative '../lib/range'
require_relative '../lib/block'
