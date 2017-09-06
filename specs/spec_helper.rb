require 'simplecov'
SimpleCov.start

# specs/spec_helper.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'



# Require any classes
# ex require_relative 'lib/foo.rb'

require_relative '../lib/daterange'
require_relative '../lib/hotel'
require_relative '../lib/reservation'
require_relative '../lib/room'



Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
