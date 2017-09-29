require_relative 'spec_helper'

describe 'Block' do

  before(:all) do
    @check_in = Date.new(2018, 03, 11)
    @check_out = Date.new(2018, 03, 15)
    @name = "guest"
    @rooms = [1,2,3]
    @price_night = 160
  end

  describe "initialize" do
    it "creates a new instance of Block" do
      Hotel::Block.new(@name, @rooms, @check_in, @check_out, @price_night).must_be_instance_of Hotel::Block
    end

    it "initializes with a new instance of DateRange stored in @dates" do
      block = Hotel::Block.new(@name, @rooms, @check_in, @check_out, @price_night)
      block.dates.must_be_instance_of Hotel::DateRange
    end

    it "takes name, rooms, dates and a price_night" do
      block = Hotel::Block.new(@name, @rooms, @check_in, @check_out, @price_night)

      block.must_respond_to :name
      block.must_respond_to :rooms
      block.must_respond_to :dates
      block.must_respond_to :price_night
    end

    it "will not initialize if given more than 5 rooms or less than 1" do
      too_many_rooms = [1,2,3,4,5,6]
      proc { Hotel::Block.new(@name, too_many_rooms, @check_in, @check_out, @price_night)}.must_raise Hotel::Block::WrongNumberOfRoomsError
    end

    it "will not initialize if given less than 1 room" do
      no_rooms_given = []
      proc { Hotel::Block.new(@name, no_rooms_given, @check_in, @check_out, @price_night)}.must_raise Hotel::Block::WrongNumberOfRoomsError
    end
  end

  describe "total_cost" do
    it "returns total cost based on discounted price_night" do
      block = Hotel::Block.new(@name, @rooms, @check_in, @check_out, @price_night)
      block.total_cost.must_equal "$640.00"
    end
  end

  describe "rooms_available?" do
    it "returns true if there are rooms" do
      block = Hotel::Block.new(@name, @rooms, @check_in, @check_out, @price_night)
      3.times do
        block.rooms_available?.must_equal true
        block.reserve_room
      end
    end

    it "returns false if there are no rooms" do
      block = Hotel::Block.new(@name, @rooms, @check_in, @check_out, @price_night)
      3.times do
        block.reserve_room
      end
      block.rooms_available?.must_equal false
    end
  end

  describe "reserve_room" do
    it "returns an available room" do
      block = Hotel::Block.new(@name, @rooms, @check_in, @check_out, @price_night)
      3.times do
        block.rooms.must_include block.reserve_room
      end
    end

      it "raises NoRoomsError if no rooms are available" do
        block = Hotel::Block.new(@name, @rooms, @check_in, @check_out, @price_night)
        3.times do
          block.reserve_room
        end
        proc {block.reserve_room}.must_raise Hotel::Block::NoRoomsError

      end

  end


end
