# SimpleCov needs to be FIRST THING in spec helper
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/room'
require_relative '../lib/reservation'
require_relative '../lib/hotel'

reporter_options = { color:true}
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(reporter_options)

# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
