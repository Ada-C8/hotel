require_relative 'spec_helper'

describe "Room" do
  describe "initialize" do
    it "Creates a room instance object with a room number" do
      room = ReservationSystem::Room.new(1)

      room.must_be_instance_of ReservationSystem::Room
      room.number.must_equal 1

      another = ReservationSystem::Room.new(100)
      another.number.must_equal 100
    end # "Creates a room instance object with a room number"

    it "Creates a room with a rate of $200" do
      room = ReservationSystem::Room.new(1)

      room.rate.must_equal 200
    end # "Creates a room with a rate of $200"

    it "Creates a room with an empty array of reservations" do
      room = ReservationSystem::Room.new(1)

      room.nights_reserved.must_be_kind_of Array
      room.nights_reserved.must_equal []
    end
  end# "initialize"

  describe "available?" do
    before do
      @hotel_california = ReservationSystem::Hotel.new
      @fancy_room = @hotel_california.hotel[0]
      @res1 = ReservationSystem::Reservation.new(d3, 3, @fancy_room)
    end

    let(:d1) {Date.new(2018,01,01)}
    let(:d3) {Date.new(2018,01,03)}
    let(:d6) {Date.new(2018,01,06)}
    let(:blocked_rooms) {[@hotel_california.hotel[1], @hotel_california.hotel[2], @hotel_california.hotel[3]]}

    it "Returns true if a room is available for a given date range" do
      @fancy_room.available?(d1,1).must_equal true
      @fancy_room.available?(d6,20).must_equal true

      blocked_rooms.each {|room| room.available?(d1,20).must_equal true}
    end #returns true

    it "Returns false if a room is not available on any day in a date range" do
      @fancy_room.available?(d1,3).must_equal false
      @fancy_room.available?(d3,20).must_equal false

      ReservationSystem::Block.new(d3, 10, blocked_rooms, 180)

      blocked_rooms.each {|room| room.available?(d6,10).must_equal false}
    end #returns false
  end #available?

end # "Room"
