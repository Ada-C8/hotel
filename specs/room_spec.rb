require_relative 'spec_helper'

describe 'Room' do
  let(:my_room) {Hotel_System::Room.new(1)}

  describe '#reserve' do
    let (:check_in) {Date.new(2017,9,5)}
    let (:check_out) {Date.new(2017,9,7)}
    let (:later_date) {Date.new(2017,9,8)}

    it "raises an Argument Error unless passed 2 Date objects" do
      proc {my_room.reserve("today", "tomorrow")}.must_raise ArgumentError
    end

    it "raises an Argument Error if check_out is earlier than or same day as check_in" do
      proc {my_room.reserve(check_in, check_in)}.must_raise ArgumentError
      proc {my_room.reserve(check_out, check_in)}.must_raise ArgumentError
    end

    it "creates a new reservation" do
      my_room.reserve(check_in, check_out).must_be_instance_of Hotel_System::Reservation
    end

    it "adds the reservation to the room's list of reservations" do
      my_room.reserve(check_in, check_out)
      my_room.reservations.must_be_instance_of Array
      my_room.reservations.length.must_equal 1
    end

    it "raises an error for attempt to reserve already-booked room" do
      my_room.reserve(check_in, check_out)
      proc {my_room.reserve(check_in, check_out)}.must_raise ArgumentError
    end

    it "allows you to reserve a room the day someone checks out" do
      my_room.reserve(check_in, check_out)
      my_room.reserve(check_out, later_date).must_be_instance_of Hotel_System::Reservation
    end
  end

  describe '#available' do
    let (:date) {Date.new(2017,1,1)}
    let (:later_date) {Date.new(2017,7,7)}
    let (:earlier_date) {Date.new(2016,10,10)}
    let (:even_later_date) {Date.new(2017,10,10)}

    it "returns true if Date argument does not overlap with existing reservation" do
      my_room.available?(date, later_date).must_equal true
    end
    
    it 'returns false if Date argument does overlap with existing reservation' do
      my_room.reserve(date, later_date)
      my_room.available?(later_date, even_later_date).must_equal true
      my_room.available?(earlier_date, later_date).must_equal false
      my_room.available?(date, even_later_date).must_equal false
      my_room.available?(earlier_date, even_later_date).must_equal false
    end
  end
end
