require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'

# Require any classes
require_relative '../lib/hotel'
require_relative '../lib/room'
require_relative '../lib/reservation'
require_relative '../lib/dates'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
