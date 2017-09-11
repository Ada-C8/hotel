require_relative 'spec_helper'
require 'date_range'

describe "Block Class" do

  describe "#initialize" do
    before do
      @block_id = "Block1"
      @date_range = DateRange.new(Date.new(2017, 9, 1), Date.new(2017, 9, 5))
      @rooms_array = [
        BookingSystem::Room.new(1, 200.00),
        BookingSystem::Room.new(2, 200.00),
        BookingSystem::Room.new(3, 200.00),
        BookingSystem::Room.new(4, 200.00),
        BookingSystem::Room.new(5, 200.00)]
      @discount_room_rate = 0.20

      @block = BookingSystem::Block.new(@block_id, @date_range, @rooms_array, @discount_room_rate)
    end

    it "can create a block of rooms using a date range, collection of rooms and a discounted room rate" do
      @block.must_be_instance_of BookingSystem::Block
    end

    it "ensures block_id argument is a String" do
      proc { BookingSystem::Block.new(12345, @date_range, @rooms_array, @discount_room_rate) }.must_raise ArgumentError
    end

    it "ensures date range argument is a DateRange object" do
      proc { BookingSystem::Block.new(@block_id, "date_range", @rooms_array, @discount_room_rate) }.must_raise InvalidDateRangeError
    end

    it "ensures collection of rooms argument is an array" do
      proc { BookingSystem::Block.new(@block_id, @date_range, "rooms_array", @discount_room_rate) }.must_raise ArgumentError
    end

    it "ensures collection of rooms argument array length cannot be greater than 5" do
      proc { BookingSystem::Block.new(@block_id, @date_range, [1, 2, 3, 4, 5, 6], @discount_room_rate) }.must_raise BlockError
    end

    it "ensures room discount argument is a float" do
      proc { BookingSystem::Block.new(@block_id, @date_range, @rooms_array, "discount_room_rate") }.must_raise ArgumentError
    end
  end
end#of_"Block Class"
