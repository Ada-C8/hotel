require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'date'
require_relative '../lib/daterange.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/admin.rb'
require_relative '../lib/block.rb'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
