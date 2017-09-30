require_relative 'spec_helper'

describe "block" do
  before do
    @block_name = "Wedding"
    checkin = Date.new(2017, 01, 01)
    checkout = Date.new(2017, 01, 04)
    @date_range = Booking::DateRange.new(checkin, checkout)
    @rooms = [12, 13, 14]
    @discounted_room_rate = 150
    @block = Booking::Block.new(@block_name, @date_range, @rooms, @discounted_room_rate)
  end

  describe "initialize" do

    it "should create an instance of a block" do
      @block.must_be_kind_of Booking::Block
    end

    it "should create an instance variable block_name" do
      @block.must_respond_to :block_name
      @block.block_name.must_equal @block_name
      @block.block_name.must_be_kind_of String
    end
  end

  describe "has_room_number method" do
    it "should check if room number exists in block " do
      # @block.available_rooms.must_equal[12, 13, 14]
      @block.has_room_number?(14)
      @block.available_rooms.must_equal [12,13,14]

      @block.has_room_number?(14)
      @block.already_reserved_rooms.must_equal []
    end
  end
end
