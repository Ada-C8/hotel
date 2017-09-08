
require 'SimpleCov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'pry'
require 'date'

require_relative '../lib/Room.rb'
require_relative '../lib/Reservations.rb'
require_relative '../lib/Booking.rb'
require_relative '../lib/DateRange.rb'
require_relative '../lib/Block.rb'
