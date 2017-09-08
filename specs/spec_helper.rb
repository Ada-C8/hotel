require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/admin'
require_relative '../lib/reservation'
require_relative '../lib/concerns/dateable'
require_relative '../lib/concerns/reserveable'



Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
