# specs/spec_helper.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require 'simplecov'
SimpleCov.start

# Require any classes
# ex require_relative 'lib/foo.rb'
require_relative '../lib/hotel'
require_relative '../lib/reservation'
require_relative '../lib/date_range'
# require_relative '../lib/*'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
