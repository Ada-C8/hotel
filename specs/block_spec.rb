require_relative 'spec_helper'

describe "Block" do

  let(:booking) { BookingSystem::Block.new("Bob", '2001-02-03', '2001-02-05', [1,2,3,4,5]) }
  let(:hotel) { BookingSystem::Hotel.new }

  describe "#initialize" do
    it "should create a new instance of BookingSystem::Block" do
      booking.must_be_instance_of BookingSystem::Block

      booking.must_respond_to :reserved_for
      booking.reserved_for.must_be_kind_of String
      booking.reserved_for.must_equal "Bob"

      booking.must_respond_to :check_in
      booking.check_in.must_be_instance_of Date

      booking.must_respond_to :check_out
      booking.check_out.must_be_kind_of Date

      booking.must_respond_to :avail_block_rooms
      booking.avail_block_rooms.map { |room_num| room_num.must_be_kind_of Integer}

      booking.avail_block_rooms.must_be_kind_of Array
      booking.avail_block_rooms.length.must_equal 5

      booking.must_respond_to :reserved_rooms
      booking.reserved_rooms.must_be_kind_of Array
      booking.reserved_rooms.must_be_empty

      booking.must_respond_to :block_total
      booking.block_total.must_be_kind_of Integer
      booking.block_total.must_equal 0
    end
  end # Describe

  describe "#reserve_rooms(num_to_book)" do
    it "should reserve first 5 requested rooms in the block" do
      booking.reserve_rooms(5)

      booking.avail_block_rooms.must_be_empty
      booking.reserved_rooms.must_equal [1,2,3,4,5]
    end

    it "should reserve first requested room in the block" do
      booking.reserve_rooms(1)

      booking.avail_block_rooms.must_equal [2,3,4,5]
      booking.reserved_rooms.must_equal [1]
    end
  end # Describe

end # Describe
