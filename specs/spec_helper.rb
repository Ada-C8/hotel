require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../Lib/player'
require_relative '../Lib/scrabble'
require_relative '../Lib/tile_bag'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
