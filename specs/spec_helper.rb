require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require 'minitest/skip_dsl'

require_relative '../lib/hotel'
require_relative '../lib/date_range'
require_relative '../lib/reservation'
require_relative '../lib/block'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
