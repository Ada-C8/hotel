require 'simplecov'
SimpleCov.start

require 'date'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'

# require 'pry'
# require 'pry-nav'

require_relative '../lib/room'
require_relative '../lib/booking'
require_relative '../lib/reservations'
require_relative '../lib/date_range'
require_relative '../lib/block'
