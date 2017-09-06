require_relative 'spec_helper'

describe "Reservation" do
  describe "initialize" do
    it "Creates a Reservation with a check-in date, a room and a number of nights" do
      ada_inn = Hotel::Building.new
      date = '2017-02-12'
      res1 = Hotel::Reservation.new(date, 9, ada_inn.rooms[0])

      res1.must_be_instance_of Hotel::Reservation
      res1.check_in.must_be_kind_of Date
      res1.check_in.must_equal Date.parse('2017-02-12')
      res1.room.must_be_instance_of Hotel::Room
      res1.room.number.must_equal 1
      res1.nights.must_be_kind_of Integer
      res1.nights.must_equal 9

      ## TODO 4 Iffy as to whether or not I want to do this
      res2 = Hotel::Reservation.new(date, 4, ada_inn.rooms[1])

      puts Hotel::Reservation.all
    end

  end

  describe "self.all method" do ##TODO see todo 4
    it "Can list all reservations by date" do

    end
  end
end
