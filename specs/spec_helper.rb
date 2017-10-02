
require 'SimpleCov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'pry'
require 'date'

require_relative '../lib/room.rb'
require_relative '../lib/reservations.rb'
require_relative '../lib/booking.rb'
require_relative '../lib/date_range.rb'
require_relative '../lib/block.rb'
