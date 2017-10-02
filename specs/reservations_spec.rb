require 'pry'
require_relative 'spec_helper'

describe 'Reservations class' do
  before do
    @hotel_res = Hotel::Reservations.new

    @start_date = Date.new(2017,9,1)
    @end_date = Date.new(2017,9,3)
    date_range = Hotel::DateRange.new(@start_date, @end_date)

    room = @hotel_res.all_rooms[0]
    booking1 = Hotel::Booking.new(1, [room], date_range)
    @hotel_res.all_reservations << booking1

    @booking2 = @hotel_res.make_booking(1, @start_date, @end_date)
  end
  describe 'initialize' do
    it 'can be instantiated' do
      @hotel_res.must_be_kind_of Hotel::Reservations
    end

    it 'creates all rooms' do
      @hotel_res.all_rooms.must_be_kind_of Array
      @hotel_res.all_rooms[0].must_be_kind_of Hotel::Room
      @hotel_res.all_rooms[0].number.must_equal 1
      @hotel_res.all_rooms.length.must_equal 20
    end

    it 'creates all_reservations' do
      @hotel_res.all_reservations.must_be_kind_of Array
    end
  end




  describe 'make_booking' do
    it 'creates a new booking' do
      @booking2.must_be_kind_of Hotel::Booking
    end

    it 'adds a booking to all_reservations' do
      @hotel_res.all_reservations[0].must_be_kind_of Hotel::Booking
      @hotel_res.all_reservations.length.must_equal 2
    end
    it 'still works for the first booking ever' do
      hotel_res_other = Hotel::Reservations.new
      hotel_res_other.make_booking(1, @start_date, @end_date).must_be_kind_of Hotel::Booking
      hotel_res_other.all_reservations.length.must_equal 1
    end

    it 'raises exception when no rooms are available' do
      @hotel_res.make_booking(18, @start_date, @end_date)
      proc {@hotel_res.make_booking(1, @start_date, @end_date)}.must_raise Hotel::RoomQuantityError
    end

    it 'creates consecutive id numbers for new bookings' do
      @booking2.id.must_equal 2
      booking3 = @hotel_res.make_booking(1, @start_date, @end_date)
      booking3.id.must_equal 3
    end

    it 'chooses the next numerically consecutive room when previous are full' do
      @booking2.rooms[0].number.must_equal 2
      booking3 = @hotel_res.make_booking(1, @start_date, @end_date)
      booking3.rooms[0].number.must_equal 3
    end

    it 'room is marked as reserved' do
      @booking2.rooms[0].reserved.must_equal true
    end

    it 'makes bookings that can start on checkout day' do
      date1 = Date.new(2017,12,1)
      @hotel_res.make_booking(20, date1, (date1 + 1))
      @hotel_res.make_booking(20, (date1 + 2), (date1 + 3))

      proc {@hotel_res.make_booking(1, date1, (date1 + 1))}.must_raise Hotel::RoomQuantityError
      proc {@hotel_res.make_booking(1, date1, (date1 + 2))}.must_raise Hotel::RoomQuantityError
      @hotel_res.make_booking(1, (date1 + 1), (date1 + 2)).must_be_kind_of Hotel::Booking
    end
  end

  describe 'make a block' do
    before do
      @block_booking = @hotel_res.make_booking(5, @start_date, @end_date, block: true)
    end
    it "can create a block reservation (and it doesn't mess anything else up.)" do
      @block_booking.must_be_kind_of Hotel::Booking
      @block_booking.must_be_kind_of Hotel::Block
    end

    it 'has 5 rooms, but none are reserved' do
      @block_booking.rooms.length.must_equal 5
      @block_booking.rooms.each do |room|
        room.reserved.must_equal false
      end
    end

    it 'can only have 5 rooms per block' do
      proc {@hotel_res.make_booking(6, @start_date, @end_date, block: true)}.must_raise Hotel::RoomQuantityError

    end

    it 'can reserve a room within a block' do
      @hotel_res.reserve_block_room(@block_booking, 1)
      @block_booking.rooms.length.must_equal 5
      @block_booking.rooms[0].reserved.must_equal true
      @block_booking.rooms[4].reserved.must_equal false
    end

    it 'reserving a room creates a new reservation, linked to the block' do
      room_reserve =   @hotel_res.reserve_block_room(@block_booking, 1)

      room_reserve.id.wont_equal @block_booking.id

      @hotel_res.all_reservations.length.must_equal room_reserve.id

      room_reserve.block_id.must_equal @block_booking.block_id

      room_reserve2 =   @hotel_res.reserve_block_room(@block_booking, 1)

      @hotel_res.all_reservations.length.must_equal room_reserve2.id

    end

    it 'reserving rooms within only works on blocks' do
      proc {  @hotel_res.reserve_block_room(@booking2, 1)}.must_raise NoMethodError
    end

    it 'reserved room has the same date_range as block' do
      room_reserve =   @hotel_res.reserve_block_room(@block_booking, 1)
      @block_booking.date_range.must_equal room_reserve.date_range
    end


    it 'can return a list of availbe rooms within the block' do
      @hotel_res.reserve_block_room(@block_booking, 1)
      @block_booking.rooms_available.length.must_equal 4
      @block_booking.rooms_available[0].must_be_kind_of Hotel::Room
    end

    it "can't reserve more rooms than the block has left." do
      @hotel_res.reserve_block_room(@block_booking, 4)
      proc {  @hotel_res.reserve_block_room(@block_booking, 2)}.must_raise Hotel::RoomQuantityError

    end

    it 'blocks recieve a 20% discount' do
      @block_booking.total_cost.must_equal 800
    end

  end


  describe 'check_reserved' do
    it 'returns an array of rooms' do
      @hotel_res.check_reserved(@start_date, @end_date).must_be_kind_of Array
      @hotel_res.check_reserved(@start_date, @end_date)[0].must_be_kind_of Hotel::Room
    end

    it 'returns an empty/full array if nothing/everything is reserved on that day' do
      date1 = Date.new(2017,10,1)
      date2 = Date.new(2017,10,2)
      @hotel_res.check_reserved(date1, date2).must_be_empty
      @hotel_res.check_availability(date1, date2).length.must_equal 20

    end



  end

  describe 'check_availability' do
    it 'returns an array of rooms' do
      @hotel_res.check_availability(@start_date, @end_date).must_be_kind_of Array
      @hotel_res.check_availability(@start_date, @end_date)[0].must_be_kind_of Hotel::Room
    end

    it 'returns an empty array if everything is reserved on that day' do
      date1 = Date.new(2017,10,1)
      date2 = Date.new(2017,10,2)
      @hotel_res.make_booking(20, date1, date2)
      @hotel_res.check_availability(date1, date2).must_be_empty

    end
    it "doesn't include any rooms from a block in the result, regardless of reserved." do
      block_booking2 = @hotel_res.make_booking(5, @start_date, @end_date, block: true)
      @hotel_res.reserve_block_room(block_booking2, 2)

      @hotel_res.check_availability(@start_date, @end_date).each do |room|
        block_booking2.rooms.each do |block_room|
          room.number.wont_equal block_room.number
        end
      end

    end
  end
end
