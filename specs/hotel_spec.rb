require_relative 'spec_helper'

describe "Hotel" do
  let(:ada_inn) { ReservationSystem::Hotel.new }
  let(:room_4) { ada_inn.hotel[3] }
  let(:room_5) { ada_inn.hotel[4] }
  let(:room_6) { ada_inn.hotel[5] }
  let(:room_7) { ada_inn.hotel[6] }

  describe "initialize" do
    it "Creates a hotel that is an array of 20 rooms with room numbers" do
      ada_inn.hotel.must_be_kind_of Array
      ada_inn.hotel.length.must_equal 20

      ada_inn.hotel[0].must_be_instance_of ReservationSystem::Room
      ada_inn.hotel[0].number.must_equal 1
      ada_inn.hotel[-1].number.must_equal 20
      ada_inn.hotel[300].must_be_nil
    end

    it "Creates a list of reservations that is empty" do
      ada_inn.all_reservations.must_be_kind_of Array
      ada_inn.all_reservations.must_equal []
    end

  end #"initialize"

  describe "hotel instance methods" do
    before do
      @res1 = ada_inn.reserve(Date.new(2017,10,12), 3, room_4)
      @res2 = ada_inn.reserve(Date.new(2017,6,12), 7, room_5)
      @res3 = ada_inn.reserve(Date.new(2017,6,13), 1, room_6)
      @res4 = ada_inn.reserve(Date.new(2017,6,9), 3, room_7)
    end # before

    describe "reserve" do
      it "Creates a reservation object" do
        @res1.must_be_instance_of ReservationSystem::Reservation
      end # "returns a reservation object"

      it "Stores the reservation in a list of all reservations" do
        ada_inn.all_reservations.must_be_kind_of Array
        ada_inn.all_reservations.must_include @res1 && @res2
      end # "creates a reservation"

      it "Raises an error if date submitted is not a valid Date object" do
        proc {ada_inn.reserve(2017, 7, room_5)}.must_raise Reservable::DateError
        proc {ada_inn.reserve('2017-06-12', 7, room_5)}.must_raise Reservable::DateError
        proc {ada_inn.reserve(:pie, 1, room_5)}.must_raise Reservable::DateError
        proc {ReservationSystem::Reservation.new(123.40, 2, room_5)}.must_raise Reservable::DateError
        proc {ada_inn.search_reservations_by_date([123.40, "a"])}.must_raise Reservable::DateError
      end #valid_date error

      it "Raises an error if nights is not a positive integer" do
        proc {ada_inn.reserve(Date.new(2017,10,12), 0, room_5)}.must_raise Reservable::PositiveIntegerError
        proc {ReservationSystem::Reservation.new(Date.new(2017,10,12), -1, room_5)}.must_raise Reservable::PositiveIntegerError
        proc {ReservationSystem::Room.new(0.24)}.must_raise Reservable::PositiveIntegerError
      end #valid number error

      #TODO change tests to their respective methods Reservation.new and search_reservations_by_date

    end # "reserve"

    describe "search_reservations_by_date" do
      it "Can list reservations including a specific date" do
        list = ada_inn.search_reservations_by_date(Date.new(2017,06,13))

        list.must_be_kind_of Array
        list.must_include @res2 && @res3
        list.wont_include @res1 && @res4
      end #" Can list reservations including a specific date"

    end # "search_reservations_by_date"

    describe "search_available_rooms_by_dates" do
      it "Can list available rooms by date range" do
        search1 = ada_inn.search_available_rooms_by_dates(Date.new(2017,06,12),3)

        search1.must_be_kind_of Array
        search1.must_include room_4 && room_7
        search1.wont_include room_5 && room_6
      end # "Can list available rooms by date range"

    end # "search_available_rooms_by_dates"

  end # "hotel instance methods"

end #"Hotel"
