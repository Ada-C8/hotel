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


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
