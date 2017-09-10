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

    it "Changes room rate to block rate" do
      block.rooms.each {|room| room.rate.must_equal 120}

      block.rooms.each {|room| room.rate.wont_equal ReservationSystem::Hotel::BASE_ROOM_RATE}
    end # "Changes room rate to block rate"

  end # initialize
end # Block class

# TODO All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations
