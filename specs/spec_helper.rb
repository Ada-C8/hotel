require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/hotel'
require_relative '../lib/daterange'
require_relative '../lib/reservation'
require_relative '../lib/booking_error'
require_relative '../lib/block'
