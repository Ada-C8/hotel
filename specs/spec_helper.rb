require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'

# Require any classes
require_relative '../lib/date_range'
require_relative '../lib/reservation'
# require_relative '../lib/tile_bag'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
