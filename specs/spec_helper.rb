require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require 'minitest/skip_dsl'

# Require any classes
# ex require_relative 'lib/foo.rb'
require_relative '../lib/hotel'
require_relative '../lib/date_range'
require_relative '../lib/reservation'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
