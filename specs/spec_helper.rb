require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/admin'
require_relative '../lib/reservation'
require_relative '../lib/concerns/dateable'
require_relative '../lib/concerns/reserveable'
require_relative '../lib/room'



Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
