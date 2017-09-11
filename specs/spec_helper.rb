require 'simplecov'
SimpleCov.start

# specs/spec_helper.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require 'minitest/skip_dsl'



# Require any classes
# ex require_relative 'lib/foo.rb'

require_relative '../lib/daterange'
require_relative '../lib/admin'
require_relative '../lib/reservation'
require_relative '../lib/block'



#
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
