require_relative 'spec_helper'

describe 'Reservations' do
  before do
    @new_hotel = Hotel::Reservations.new
  end
  describe 'initialize' do
    it "must be an instance of Reservations" do
      @new_hotel.must_be_instance_of Hotel::Reservations
    end
  end

  describe "collection of rooms" do
    it "has a collection of rooms" do
      @new_hotel.all_rooms.must_be_kind_of Array
    end
    ##TODO: write more tests here ##
  end

  describe 'all reservations' do
    it "has a collection of reservations" do
      @new_hotel.all_reservations.must_be_kind_of Array
    end
  end

  describe 'new reservation' do
    before do
      @new_hotel.clear_reservations
      @new_hotel1 = Hotel::Reservations.new
    end
    it 'must create a new booking' do
      new_booking1 = @new_hotel1.new_reservation("2017-09-21", "2017-09-23", 1)
      new_booking1.must_be_instance_of Hotel::Booking
    end
    it 'must raise an error if the check-in date is in the past' do

      proc{new_booking = @new_hotel1.new_reservation("2017-06-01", "2017-09-21", 2)}.must_raise Hotel::InvalidDateError
    end
    it 'must raise an error if the check-in date is the same as the check-out date' do
      proc{new_booking = @new_hotel1.new_reservation("2017-09-20", "2017-09-20"), 3}.must_raise Hotel::InvalidDateError
    end
    it 'must raise an error if the check_in date is after the check-out date' do
      proc{new_booking = @new_hotel1.new_reservation("2017-09-20", "2017-09-18"), 4}.must_raise Hotel::InvalidDateError
    end
    it 'must raise an error if the date is not valid on calendar' do
      proc{new_booking = @new_hotel1.new_reservation("2018-02-30", "2018-02-31"), 5}.must_raise ArgumentError
    end
    it 'allows a new reservation to be made on a room on the same day as previous check-out' do
      @new_hotel1.clear_reservations
      @new_reservation1 = @new_hotel1.new_reservation("2018-01-01", "2018-01-05", 1)
      @new_reservation2 = @new_hotel1.new_reservation("2018-01-05", "2018-01-07", 1)
      @new_hotel1.all_reservations.length.must_equal 2
    end
  end

  describe 'check availability' do
    before do
      @new_hotel.clear_reservations
      @new_reservation1 = @new_hotel.new_reservation("2018-01-01", "2018-01-05", 1)
    end
    # after do
    #   @new_hotel.clear_reservations
    # end
    it 'must must raise argument error if room is not available' do
      proc{ new_reservation2 = @new_hotel.new_reservation("2018-01-01", "2018-01-04", 1) }.must_raise ArgumentError
    end
  end

  describe 'list rooms available by date' do
    before do
      @new_hotel.clear_reservations
      @new_reservation1 = @new_hotel.new_reservation("2018-01-01", "2018-01-05", 1)
      @new_reservation2 = @new_hotel.new_reservation("2018-01-01", "2018-01-05", 2)
      @new_reservation3 = @new_hotel.new_reservation("2018-01-01", "2018-01-05", 10)
    end
    after do
      @new_hotel.clear_reservations
    end
    it 'must return an array' do
      @new_hotel.list_rooms_available_by_date("2018-01-02").must_be_kind_of Array
    end
    it 'must return the correct number of rooms available' do
      @new_hotel.list_rooms_available_by_date("2018-01-03").length.must_equal 17
    end
    it 'must return the correct rooms available' do
      @new_hotel.list_rooms_available_by_date("2018-01-03")[0].room_number.must_equal 3
    end
  end
  # describe 'assign room number' do
  #   it 'will assign a room number if no room number is given' do
  #     new_booking = @new_hotel.new_reservation("2017-09-21", "2017-09-23")
  #     new_booking.room_number.wont_equal 0
  #   end
  # end

  # describe 'validate room number' do
  #   after do
  #     @new_hotel.clear_reservations
  #   end
  #   it 'must raise an error if a room number that does not exist is entered' do
  #     proc{new_booking = @new_hotel.new_reservation("2017-09-21", "2017-09-30", 45)}.must_raise ArgumentError
  #   end
  # end

  describe 'all reservations' do
    before do
      @new_hotel.clear_reservations
      @new_booking1 = @new_hotel.new_reservation("2017-09-21", "2017-09-23", 2)
      @new_booking2 = @new_hotel.new_reservation("2020-01-01", "2020-01-15", 3)
      @new_booking3 = @new_hotel.new_reservation("2019-01-01", "2019-01-15", 5)
    end
    it 'must be an array of all reservations' do
      @new_hotel.all_reservations.must_be_kind_of Array
    end
    it 'must contain correct number of reservations made' do
      @new_hotel.all_reservations.length.must_equal 3
    end
    it 'must contain the first reservation made' do
      @new_hotel.all_reservations[0].check_in.must_equal Date.parse("2017-09-21")
    end
    it 'must contain the correct total cost of the reservation' do
      @new_hotel.all_reservations[0].total_cost.must_equal 400
    end
  end

  describe 'list_reservations_by_date' do
    before do
      @new_hotel.clear_reservations
      @new_booking1 = @new_hotel.new_reservation("2017-09-21", "2017-09-23", 1)
      @new_booking2 = @new_hotel.new_reservation("2019-01-01", "2019-01-15", 10)
      @new_booking3 = @new_hotel.new_reservation("2019-01-02", "2019-01-12", 12)
      @new_booking4 = @new_hotel.new_reservation("2019-01-01", "2019-01-13", 15)
    end
    it "must be a method of Reservations" do
      @new_hotel.must_respond_to :list_reservations_by_date
    end
    it "must be an array" do
      @new_hotel.list_reservations_by_date("2019-01-01").must_be_kind_of Array
    end
    it "must have the correct number of reservations for the date given" do
      @new_hotel.list_reservations_by_date("2019-01-04").length.must_equal 3
    end
    it "must return the correct reservations" do
      @new_hotel.list_reservations_by_date("2017-09-21")[0].room_number.must_equal @new_booking1.room_number
    end
  end

  describe 'make a new block' do
    before do
      @new_hotel.clear_reservations
      @new_block = @new_hotel.new_block("2018-01-01", "2018-01-10", "Heritage", 5)
      #@new_block2 = @new_hotel.new_block("2018-02-02", "2018-02-05", 3)
    end
    after do
      @new_hotel.clear_reservations
    end
    it 'must be an instance of a block' do
      @new_block.must_be_instance_of Hotel::Block
    end
    it 'must add the block to the blocks collection' do
      @new_hotel.blocks_collection.must_include(@new_block)
    end
    it 'must have a collection of rooms' do
      @new_block.block_rooms_collection.must_be_kind_of Array
    end
    it 'must have the correct number of rooms in the collection' do
      @new_block.block_rooms_collection.length.must_equal 5
    end
  end

  describe 'list block rooms by date' do
    before do
      @new_hotel.clear_reservations
      @new_block = @new_hotel.new_block("2018-01-01", "2018-01-10", "Heritage", 5)
    end
    it 'must list the correct number of rooms for a given date' do
      @new_hotel.list_blocked_rooms_by_date("2018-01-02").length.must_equal 5
    end
  end

  describe 'reserve a room in a block' do
    before do
      @new_hotel_with_blocks = Hotel::Reservations.new
      @new_booking1 = @new_hotel_with_blocks.new_reservation("2018-01-01", "2018-01-05", 1)
      @new_booking2 = @new_hotel_with_blocks.new_reservation("2018-01-01", "2018-01-04", 2)
      @new_booking3 = @new_hotel_with_blocks.new_reservation("2018-01-01", "2018-01-05", 3)
      @new_booking4 = @new_hotel_with_blocks.new_reservation("2018-01-01", "2018-01-13", 4)
      @new_block = @new_hotel_with_blocks.new_block("2018-01-01", "2018-01-10", "Heritage", 5)
      @new_block_reservation = @new_hotel_with_blocks.new_reservation_in_block("2018-01-01", "2018-01-05", "Heritage", 6)
    end
    it 'must be an instance of Hotel Booking' do
      @new_block_reservation.must_be_instance_of Hotel::Booking
    end
    it 'must raise an error if the room is not in the block' do
      proc {@new_block_reservation1 = @new_hotel_with_blocks.new_reservation_in_block("2018-01-01", "2018-01-05", "Heritage", 20)}.must_raise ArgumentError
    end
    it 'must raise an error if the room selected is not available' do
      proc { @new_block_reservation1 = @new_hotel_with_blocks.new_reservation_in_block("2018-01-01", "2018-01-05", "Heritage", 6)}.must_raise ArgumentError
    end
  end

  describe 'block has rooms available' do
    before do
      @new_hotel_with_blocks1 = Hotel::Reservations.new
      @new_booking1 = @new_hotel_with_blocks1.new_reservation("2018-01-01", "2018-01-05", 1)
      @new_booking2 = @new_hotel_with_blocks1.new_reservation("2018-01-01", "2018-01-04", 2)
      @new_booking3 = @new_hotel_with_blocks1.new_reservation("2018-01-01", "2018-01-05", 3)
      @new_booking4 = @new_hotel_with_blocks1.new_reservation("2018-01-01", "2018-01-13", 4)
      @new_block = @new_hotel_with_blocks1.new_block("2018-01-01", "2018-01-10", "Heritage", 5)
      @new_block_reservation = @new_hotel_with_blocks1.new_reservation_in_block("2018-01-01", "2018-01-05", "Heritage", 6)
      @new_block_reservation2 = @new_hotel_with_blocks1.new_reservation_in_block("2018-01-01", "2018-01-05", "Heritage", 7)
    end
    it 'must return true if there are rooms available in block to be booked' do
      @new_block.has_rooms_available?.must_equal true
    end
    it 'must return false if there are NOT any rooms available in block to be booked' do
      @new_block_reservation3 = @new_hotel_with_blocks1.new_reservation_in_block("2018-01-01", "2018-01-05", "Heritage", 8)
      @new_block_reservation4 = @new_hotel_with_blocks1.new_reservation_in_block("2018-01-01", "2018-01-05", "Heritage", 9)
      @new_block_reservation5 = @new_hotel_with_blocks1.new_reservation_in_block("2018-01-01", "2018-01-05", "Heritage", 5)

      @new_block.has_rooms_available?.must_equal false
    end
  end

  describe 'block room reservation will match with block date range' do
    it 'must raise an arugment error if the dates are outside of the range' do
      new_hotel = Hotel::Reservations.new
      new_block = new_hotel.new_block("2018-01-01", "2018-01-10", "Heritage", 5)
      proc {new_block_reservation = new_hotel.new_reservation_in_block("2018-01-01", "2018-01-15", "Heritage", 5)}.must_raise ArgumentError
    end
  end
end
