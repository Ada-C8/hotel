
 require 'simplecov'
 SimpleCov.start
 require 'minitest'
 require 'minitest/autorun'
 require 'minitest/reporters'
 require_relative '../lib/hotel'
 require_relative '../lib/date_range'
 require_relative '../lib/reservations'
 require_relative '../lib/block'

 require 'date'

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new
