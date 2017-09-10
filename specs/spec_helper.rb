require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require 'date'

require_relative '../lib/reservations'
require_relative '../lib/room'
require_relative '../lib/booking'
require_relative '../lib/date_range'
require_relative '../lib/block'
require_relative '../lib/custom_exceptions'
# require_relative '../lib/test'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
