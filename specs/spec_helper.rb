require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'date'

require_relative '../lib/room'
require_relative '../lib/reservation'

reporter_options = { color:true}
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(reporter_options)

# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
