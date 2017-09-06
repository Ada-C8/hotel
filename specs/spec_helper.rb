require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/Hotel'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

module Hotel
  class Room
    def self.clear
      @@rooms = []
    end
  end

  class Reservation
    def self.clear
      @@reservations = []
    end
  end

  class Block
    def self.clear
      @@blocks = []
    end
  end
end
