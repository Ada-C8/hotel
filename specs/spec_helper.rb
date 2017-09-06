require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require 'minitest/skip_dsl'

# Require any classes
# ex require_relative 'lib/foo.rb'

require_relative '../lib/room'
require_relative '../lib/reservation'
require_relative '../lib/date_range'
require_relative '../lib/booking'
# require_relative '../lib/'

# require_relative '../lib/'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
