require_relative 'spec_helper'

describe "Hotel" do
  let(:ada_inn) { ReservationSystem::Hotel.new }
  let(:room_4) { ada_inn.hotel[3] }
  let(:room_5) { ada_inn.hotel[4] }
  let(:room_6) { ada_inn.hotel[5] }
  let(:room_7) { ada_inn.hotel[6] }
  let(:room_8) { ada_inn.hotel[7] }
  let(:room_9) { ada_inn.hotel[8] }


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

    let(:d1) {Date.new(2020,01,01)}
    let(:d2) {Date.new(2017,6,12)}
    let(:d6) {Date.new(2018,01,06)}
    # let(:new_block) { ReservationSystem::Block.new(d6,2,[room_4, room_5, room_6, room_7], 120)}

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
      end #valid_date error

      it "Raises an error if nights is not a positive integer" do
        proc {ada_inn.reserve(Date.new(2017,10,12), 0, room_5)}.must_raise Reservable::PositiveIntegerError
        proc {ada_inn.reserve(Date.new(2017,10,12), -1, room_5)}.must_raise Reservable::PositiveIntegerError
        proc {ada_inn.reserve(Date.new(2017,10,12), 0.24, room_5)}.must_raise Reservable::PositiveIntegerError
      end #valid number error

      it "Raises an error if the room is unavailable for given date range" do
        proc {ada_inn.reserve(Date.new(2017,10,13), 1, room_4)}.must_raise Reservable::UnavailableError
        proc {ada_inn.reserve(Date.new(2017,6,10), 5, room_5)}.must_raise Reservable::UnavailableError
        proc {ada_inn.reserve(Date.new(2017,6,10), 1, room_7)}.must_raise Reservable::UnavailableError

        ada_inn.reserve(Date.new(2017,6,14), 20, room_6) #because there is no wont_raise
      end
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

    describe "reserve_block" do
      let(:block_res) {ada_inn.reserve_block(d1, 2, [room_4, room_5], 150)}

      it "Creates a block object" do
        block_res.must_be_instance_of ReservationSystem::Block
      end # "returns a block object"

      it "Limits the maximum number of rooms to 5" do
        proc {ada_inn.reserve_block(d6,2,[room_4, room_5, room_6, room_7, room_8, room_9], 120)}.must_raise Reservable::RoomLimit
      end # "Limits the maximum number of rooms to 5"

      it "Raises an error if a room is already reserved or blocked" do
        proc {ada_inn.reserve_block(d2,1,[room_5], 120)}.must_raise Reservable::UnavailableError

        block_res
        proc {ada_inn.reserve_block(d1+1,3,[room_4, room_5, room_6, room_7], 120)}.must_raise Reservable::UnavailableError
      end # "Raises an error if a room is already reserved or blocked"
    end # reserve_block

    describe "search_available_rooms" do
      let(:block) {ada_inn.reserve_block(d1, 2, [room_4, room_5], 150)}

      it "Can check whether a given block has any rooms available" do
        block
        ada_inn.search_available_rooms(block).must_be_kind_of Array
        ada_inn.search_available_rooms(block).must_include room_4 && room_5
        ada_inn.search_available_rooms(block).wont_include room_7

        ada_inn.reserve_within(block, room_4)

        ada_inn.search_available_rooms(block).must_include room_5
        ada_inn.search_available_rooms(block).wont_include room_4
      end # "Can check whether a given block has any rooms available"
    end # "search_available_rooms"

    describe "reserve_within" do
      let(:block) {ada_inn.reserve_block(d1, 2, [room_4, room_5], 150)}

      it "Can reserve a room from within a block" do
        ada_inn.reserve_within(block, room_4).must_be_instance_of ReservationSystem::Reservation
      end #"Can reserve a room from within a block"

      it "Has reservation dates that match date range of the block" do
        ada_inn.reserve_within(block, room_4)
        room_4.nights_reserved.must_include d1 && d1+1
      end # "Has reservation dates that match date range of the block"

      it "Cannot reserve a room that is not within the block" do
        proc {ada_inn.reserve_within(block, room_7)}.must_raise Reservable::UnavailableError
      end

      it "Cannot reserve a room that is already reserved" do
        ada_inn.reserve_within(block, room_4)
        proc {ada_inn.reserve_within(block, room_4)}.must_raise Reservable::UnavailableError
      end
    end # "reserve_within"

    describe "override_rate" do #TODO decide if ovverride is available for a reservation or for a room in general
      it "Can change a room rate" do
        #TODO changes room rate, check reservation prices are updated
      end
    end

  end # "hotel instance methods"

end #"Hotel"
