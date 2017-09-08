require_relative 'spec_helper'

describe "Block" do

  before do
    reserved_rooms = [1,2,3,4,5]
    @booking = BookingSystem::Block.new("Bob", '2001-02-03', '2001-02-05',reserved_rooms )
  end

  describe "#initalize" do
    it "should create a new instance of BookingSystem::Block" do
      @booking.must_be_instance_of BookingSystem::Block

      @booking.must_respond_to :reserved_for
      @booking.reserved_for.must_be_kind_of String
      @booking.reserved_for.must_equal "Bob"

      @booking.must_respond_to :check_in
      #TODO: Must make sure the correct input is given a a regex
      @booking.check_in.must_be_instance_of String

      @booking.must_respond_to :check_out
      #TODO: Must make sure the correct input is given a a regex
      @booking.check_out.must_be_kind_of String

      @booking.must_respond_to :reserved_rooms
      @booking.reserved_rooms.each do |room_num|
        room_num.must_be_kind_of Integer
      end
      @booking.reserved_rooms.must_be_kind_of Array
      @booking.reserved_rooms.length.must_equal 5

      @booking.must_respond_to :block_total
      @booking.block_total.must_be_kind_of Integer
      @booking.block_total.must_equal 0

      @booking.must_respond_to :avail_block_rooms
      @booking.avail_block_rooms.must_be_empty
      @booking.avail_block_rooms.must_be_kind_of Array
    end
  end # Describe

end # Describe
