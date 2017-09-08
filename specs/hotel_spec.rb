require_relative 'spec_helper'

describe "Hotel" do
  before do
    @two_rooms = {1 => 150, 2 => 200}
    @five_rooms = {1 => 150, 2 => 200, 3 => 350, 4 => 120, 5 => 170}
    @seven_rooms = {1 => 150, 2 => 200, 3 => 350, 4 => 120, 5 => 150, 6 => 170, 7 => 180}
    @two_rooms_hotel = BookingSystem::Hotel.new(@two_rooms)
    @check_in = Date.new(2017,9,15)
    @check_out = Date.new(2017,9,17)
    @date_range = BookingSystem::DateRange.new(@check_in, @check_out)
    @five_rooms_hotel = BookingSystem::Hotel.new(@five_rooms)
  end

  # after do
  #   @two_rooms_hotel.reset_hotel
  # end

  describe "#initialize" do
    it "@rooms should be kind of hash" do
      @two_rooms_hotel.rooms.must_be_kind_of Hash
    end
    it "Should return an array of the rigth length" do
      @two_rooms_hotel.rooms.length.must_equal 2
    end
    it "Each room should be kind of integer" do
      @two_rooms_hotel.rooms.keys[0].must_be_kind_of Integer
    end
    it "All_reservations must be kind of array" do
      @two_rooms_hotel.all_reservations.must_be_kind_of Array
    end
    it "All_reservations must be empty if no reservations were made" do
      @two_rooms_hotel.all_reservations.length.must_equal 0
    end
    it "All_blocks must be kind of array" do
      @two_rooms_hotel.all_blocks.must_be_kind_of Array
    end
    it "All_blocks must be empty if no blocks were created" do
      @two_rooms_hotel.all_blocks.length.must_equal 0
    end
  end

  describe "#room_unavailable" do
    it "Returns an array of dates for given room number" do
      @two_rooms_hotel.room_unavailable(1).must_be_kind_of Array
    end
    it "Returns empty array if no reservations were made for given room number" do
      @two_rooms_hotel.room_unavailable(1).length.must_equal 0
    end
    it "Returns an array of one element if one reservation was made for given room number" do
      new_reservation = @two_rooms_hotel.make_reservation(@date_range, 1)
      @two_rooms_hotel.room_unavailable(1).length.must_equal @date_range.dates_within_range.length
    end
    it "Returns an array of dates if one block was created" do
      new_block = @five_rooms_hotel.create_block(@date_range, 3)
      @five_rooms_hotel.room_unavailable(1).must_equal @date_range.dates_within_range
    end
  end

  describe "#make_reservation" do
    it "Returns an instance of class reservation" do
      @two_rooms_hotel.make_reservation(@date_range, 1).must_be_kind_of BookingSystem::Reservation
    end
    it "Adds new reservation to all_reservations array" do
      first_reservation = @two_rooms_hotel.make_reservation(@date_range, 1)
      @two_rooms_hotel.all_reservations.length.must_equal 1
    end

    it "Raise an error if asked to reserve a room that is not available" do
      reservation = @two_rooms_hotel.make_reservation(@date_range, 1)
      proc { @two_rooms_hotel.make_reservation(@date_range, 1) }.must_raise ArgumentError
    end
  end

  describe "#list_of_reservations" do
    before do
      @reservation = @two_rooms_hotel.make_reservation(@date_range, 1)
      @second_reservation = @two_rooms_hotel.make_reservation(@date_range, 2)
      @date = Date.new(2017,9,15)
    end
    it "Returns an instance of array class " do
      @two_rooms_hotel.list_of_reservations(@date).must_be_kind_of Array
    end
    it "Returns an array of the right length" do
      @two_rooms_hotel.list_of_reservations(@date).length.must_equal 2
    end
  end

  describe "#list_of_available_rooms" do
    it "Returns an instanse of hash" do
      @two_rooms_hotel.list_of_available_rooms(@date_range).must_be_kind_of Hash
    end
    it "Returns the right list of available rooms if 1st room was booked" do
      reservation = @two_rooms_hotel.make_reservation(@date_range, 1)
      @two_rooms_hotel.list_of_available_rooms(@date_range).must_equal ({2 => 200})
    end
    it "Raise an error if no room is available for given date range" do
      reservation = @two_rooms_hotel.make_reservation(@date_range, 1)
      second_reservation = @two_rooms_hotel.make_reservation(@date_range, 2)
      proc { @two_rooms_hotel.list_of_available_rooms(@date_range) }.must_raise BookingSystem::NoRoomAvailableError
    end
  end

  describe "#create_block" do
    before do
      @five_rooms_hotel = BookingSystem::Hotel.new(@seven_rooms)
      @new_block = @five_rooms_hotel.create_block(@date_range, 2)
      @another_block = @five_rooms_hotel.create_block(@date_range, 7)
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
      proc { @five_rooms_hotel.create_block(@date_range, 4) }.must_raise BookingSystem::NoRoomAvailableError
    end
  end

  describe "#make_reservation_from_block" do
    before do
      @five_rooms_hotel = BookingSystem::Hotel.new(@five_rooms)
      @new_block = @five_rooms_hotel.create_block(@date_range, 3)
      @reservation_from_block = @five_rooms_hotel.make_reservation_from_block(@new_block)
    end
    it "Returns an instance of class Reservation" do
      @reservation_from_block.must_be_kind_of BookingSystem::Reservation
    end
    it "Booked room should be removed from rooms in block" do
      @new_block.rooms.length.must_equal 2
    end
    it "Raise an error if no available rooms for reservation from block" do
      2.times do
        @five_rooms_hotel.make_reservation_from_block(@new_block)
      end
      proc { @five_rooms_hotel.make_reservation_from_block(@new_block) }.must_raise BookingSystem::NoRoomAvailableError
    end
  end

  describe "Check total cost for two types of reservations" do
    before do
      @five_rooms_hotel = BookingSystem::Hotel.new(@five_rooms)
      @block = @five_rooms_hotel.create_block(@date_range, 3)
      @general_reservation = @five_rooms_hotel.make_reservation(@date_range, 4)
      @reservation_from_block = @five_rooms_hotel.make_reservation_from_block(@block)
    end
    it "Returns the right total cost for general reservation" do
      @general_reservation.total_cost.must_equal @five_rooms[4] * @date_range.dates_within_range.length
    end
    it "Returns the right total cost for reservation from block" do
      @reservation_from_block.total_cost.must_equal @five_rooms[1] * @date_range.dates_within_range.length * 0.9
    end
  end







end #end of describe
