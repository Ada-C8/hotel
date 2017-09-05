# specs/spec_helper.rb
require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require 'minitest/skip_dsl'
require 'pry'


# Require any classes
require_relative '../lib/hotel'
require_relative '../lib/reservation'
require_relative '../lib/date_range'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
