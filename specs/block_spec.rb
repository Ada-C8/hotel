require_relative 'spec_helper'

describe "Block class" do
  before do
    @busy_hotel = ReservationSystem::Hotel.new
    @reserved_room = @busy_hotel.hotel[6]
    @res1 = ReservationSystem::Reservation.new(d3, 3, @reserved_room)
  end

  let(:open_room) {@busy_hotel.hotel[7]}
  let(:d1) {Date.new(2020,01,01)}
  let(:d3) {Date.new(2020,01,03)}
  let(:d6) {Date.new(2018,01,06)}
  let(:block) { ReservationSystem::Block.new(d1,2,[@reserved_room, open_room], 120)}
  let(:new_block) { ReservationSystem::Block.new(d6,2,[@reserved_room, open_room], 120)}

  describe "initialize" do
    it "Creates a block of rooms as a list" do
      block.rooms.must_be_kind_of Array
      block.rooms.must_include @reserved_room && open_room
    end # "Creates a block of rooms as a list"

    it "Limits the maximum number of rooms to 5" do
      proc {ReservationSystem::Block.new(d1,2,[@reserved_room, open_room, @busy_hotel.hotel[8], @busy_hotel.hotel[9], @busy_hotel.hotel[10], @busy_hotel.hotel[11]], 120)}.must_raise Reservable::RoomLimit
    end # "Limits the maximum number of rooms to 5"

    it "Changes room rate to block rate" do
      block.rooms.each {|room| room.rate.must_equal 120}

      block.rooms.each {|room| room.rate.wont_equal ReservationSystem::Hotel::BASE_ROOM_RATE}
    end # "Changes room rate to block rate"

    #TODO move to hotel class/spec
    # it "Can't have an already blocked or reserved room" do
    #
    # end # "Can't have an already blocked or reserved room"
  end # initialize

  describe "block_available?" do
    it "Returns true if every room is available for every date given" do
      block.block_available?.must_equal true
      new_block.block_available?.must_equal true
    end # returns true

    it "Returns false if a single room is unavailable for a single date" do

    end # returns false
  end # "block_available?"

  describe "search_available_rooms_by_block" do #TODO
    it "Can check whether a given block has any rooms available" do

    end # "Can check whether a given block has any rooms available"


  end # "search_available_rooms_by_block"

  describe "reserve_block" do #TODO
    it "Can reserve a room from within a block" do

    end #"Can reserve a room from within a block"

    it "Has reservation dates that match date range of the block" do

    end # "Has reservation dates that match date range of the block"
  end # "reserve_block"


end # Block class

# TODO All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations
