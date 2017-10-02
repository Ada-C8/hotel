require_relative 'spec_helper'

describe "HotelBooking::Block class " do
  describe "initialize" do
    before do
      @check_in_str = "2018-10-03"
      @check_out_str = "2018-10-06"
      @new_hotel = HotelBooking::Hotel.new
      @room_ids= [1,2,3]
      @block_id = "Amy's Party"
      @discounted_rate = 5
      @new_block = HotelBooking::Block.new(Date.parse(@check_in_str), Date.parse(@check_out_str),@room_ids,@discounted_rate,@block_id)
    end

    it "initalizes with attributes that we can access in our booking system" do
      @new_block.must_be_instance_of HotelBooking::Block

      @new_block.id.must_equal @block_id
      @new_block.check_in.to_s.must_equal @check_in_str
      @new_block.check_out.to_s.must_equal @check_out_str

    end

    it "stores an array of room ids " do
      @new_block.room_ids.must_be_instance_of Array
      @new_block.room_ids.must_equal @room_ids
      @new_block.room_ids.each do |id|
        id.must_be_instance_of Integer
      end
    end

  end

  describe "reserve_block_room" do
    it "can reserve a room in a given block if given the check-in/out date, reservation id, and block id" do
      hotel = HotelBooking::Hotel.new

      rooms_in_block = [1,3]

      block_room_wanted = 3

      check_in = "2018-08-09"
      check_out = "2018-08-12"
      discounted_rate = 10

      hotel.make_block(check_in, check_out, rooms_in_block,discounted_rate)

      block1 = hotel.all_blocks[-1]

      hotel.all_blocks.count.must_equal 1
      block1.must_be_instance_of HotelBooking::Block
      block1.id.must_equal "B1"


      block1.reserve_block_room(block_room_wanted)

      block1.available_rooms.must_equal [1]

      # (block1.check_in...block1.check_out).each do |date|
      #   room.all_dates.must_include date
      # end

    end

  end #end reserve_block_room
end
