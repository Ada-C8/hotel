require_relative 'spec_helper'

describe "Hotel" do
  before do
    @new_hotel = BookingSystem::Hotel.new(2, 200)
    @check_in = Date.new(2017,9,15)
    @check_out = Date.new(2017,9,17)
    @date_range = BookingSystem::DateRange.new(@check_in, @check_out)
    @cost = {1 => 150, 2 => 200, 3 => 350, 4 => 120, 5 => 150}
  end

  describe "#initialize" do
    it "@rooms should be kind of array" do
      @new_hotel.rooms.must_be_kind_of Array
    end
    it "Should return an array of the rigth length" do
      @new_hotel.rooms.length.must_equal 2
    end
    it "Each room should be kind of integer" do
      @new_hotel.rooms[1].must_be_kind_of Integer
    end
    it "All_reservations must be kind of array" do
      @new_hotel.all_reservations.must_be_kind_of Array
    end
    it "All_reservations must be empty if no reservations were made" do
      @new_hotel.all_reservations.length.must_equal 0
    end
  end

  describe "#room_unavailable" do
    it "Returns an array of dates for given room number" do
      @new_hotel.room_unavailable(1).must_be_kind_of Array
    end
    it "Returns empty array if no reservations were made for given room number" do
      @new_hotel.room_unavailable(1).length.must_equal 0
    end
    it "Returns an array of one element if one reservation was made for given room number" do
      new_reservation = @new_hotel.make_reservation(@date_range)
      @new_hotel.room_unavailable(1).length.must_equal @date_range.dates_within_range.length
    end
  end

  describe "#find_room" do
    it "Returns an integer" do
      @new_hotel.find_room(@date_range).must_be_kind_of Integer
    end
    it "Should return 1 when all rooms are available" do
      @new_hotel.find_room(@date_range).must_equal 1
    end
  end

  describe "#make_reservation" do
    it "Returns an instance of class reservation" do
      @new_hotel.make_reservation(@date_range).must_be_kind_of BookingSystem::Reservation
    end
    it "Adds new reservation to all_reservations array" do
      first_reservation = @new_hotel.make_reservation(@date_range)
      @new_hotel.all_reservations.length.must_equal 1
    end
    it "Pick the next available room out of all rooms" do
      second_check_in = Date.new(2017,9,17)
      second_check_out = Date.new(2017,9,19)
      third_check_in = Date.new(2017,9,15)
      third_check_out = Date.new(2017,9,17)
      second_date_range = BookingSystem::DateRange.new(second_check_in, second_check_out)
      third_date_range = BookingSystem::DateRange.new(third_check_in, third_check_out)
      first_reservation = @new_hotel.make_reservation(@date_range)
      @new_hotel.all_reservations[0].room.must_equal 1
      @new_hotel.room_unavailable(1).length.must_equal 2
      second_reservation = @new_hotel.make_reservation(second_date_range)
      @new_hotel.room_unavailable(1).length.must_equal 4
      @new_hotel.room_unavailable(2).length.must_equal 0
      third_reservation = @new_hotel.make_reservation(third_date_range)
      @new_hotel.room_unavailable(1).length.must_equal 4
      @new_hotel.room_unavailable(2).length.must_equal 2
    end
    it "Raise an error if no room is available withing given dates" do
      reservation = @new_hotel.make_reservation(@date_range)
      second_reservation = @new_hotel.make_reservation(@date_range)
      proc { @new_hotel.make_reservation(@date_range) }.must_raise BookingSystem::NoRoomAvailableError
    end
  end

  describe "#list_of_reservations" do
    before do
      @reservation = @new_hotel.make_reservation(@date_range)
      @second_reservation = @new_hotel.make_reservation(@date_range)
      @date = Date.new(2017,9,15)
    end
    it "Returns an instance of array class " do
      @new_hotel.list_of_reservations(@date).must_be_kind_of Array
    end
    it "Returns an array of the right length" do
      @new_hotel.list_of_reservations(@date).length.must_equal 2
    end
  end

  describe "#list_of_available_rooms" do
    it "Returns an instanse of array" do
      @new_hotel.list_of_available_rooms(@date_range).must_be_kind_of Array
    end
    it "Returns the 2nd room if the 1st one is booked for hotel with 2 rooms" do
      reservation = @new_hotel.make_reservation(@date_range)
      @new_hotel.list_of_available_rooms(@date_range)[0].must_equal 2
    end
  end

  describe "#create_block" do
    before do
      @hotel = BookingSystem::Hotel.new(7, @cost)
      @new_block = @hotel.create_block(@date_range, 2)
      @another_block = @hotel.create_block(@date_range, 7)
    end
    it "Should set number_of_rooms to 5 if given integer grater than 5" do
      @another_block.rooms.length.must_equal 5
    end
    it "New block should be an instance of Block class " do
      @new_block.must_be_kind_of BookingSystem::Block
    end
    it "Created block should include given number of rooms" do
      @new_block.rooms.length.must_equal 2
    end
    it "Raise an error if no rooms available for given date range" do
      proc { @hotel.create_block(@date_range, 4) }.must_raise BookingSystem::NoRoomAvailableError
    end

  end

  describe "#make_reservation_from_block" do
    before do
      @hotel = BookingSystem::Hotel.new(5, @cost)
      @new_block = @hotel.create_block(@date_range, 3)
      @reservation_from_block = @hotel.make_reservation_from_block(@new_block)
    end
    it "Returns an instance of class Reservation" do
      @reservation_from_block.must_be_kind_of BookingSystem::Reservation
    end
    it "Booked room should be removed from rooms in block" do
      @new_block.rooms.length.must_equal 2
    end
    it "Raise an error if no available rooms for reservation from block" do
      2.times do
        @hotel.make_reservation_from_block(@new_block)
      end
      proc { @hotel.make_reservation_from_block(@new_block) }.must_raise BookingSystem::NoRoomAvailableError
    end
  end

  describe "Check total cost for two types of reservations" do
    before do
      @hotel = BookingSystem::Hotel.new(5, @cost)
      @block = @hotel.create_block(@date_range, 3)
      @general_reservation = @hotel.make_reservation(@date_range)
      @reservation_from_block = @hotel.make_reservation_from_block(@block)
    end
    it "Returns the right total cost for general reservation" do
      @general_reservation.total_cost.must_equal @cost[4] * @date_range.dates_within_range.length
    end
    it "Returns the right total cost for reservation from block" do
      @reservation_from_block.total_cost.must_equal @cost[1] * @date_range.dates_within_range.length * 0.9
    end
  end







end #end of describe
