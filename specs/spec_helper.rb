require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'



require_relative '../lib/hotel'
# require_relative '../lib/reservation'
# require_relative '../lib/block'
# require_relative '../lib/date_range'




Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
