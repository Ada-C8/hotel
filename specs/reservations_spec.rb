require 'pry'
require_relative 'spec_helper'

describe 'Reservations class' do
  before do
    @hotel_res = Hotel::Reservations.new

    @start_date = Date.new(2017,9,1)
    @end_date = Date.new(2017,9,3)
    date_range = Hotel::DateRange.new(@start_date, @end_date)

    room = @hotel_res.all_rooms[0]
    res1 = Hotel::Reservation.new(1, [room], date_range)
    @hotel_res.all_reservations << res1

    @res2 = @hotel_res.make_reservation(1, @start_date, @end_date)
  end
  describe 'initialize' do
    it 'can be instantiated' do
      @hotel_res.must_be_kind_of Hotel::Reservations
    end

    it 'creates all rooms' do
      @hotel_res.all_rooms.must_be_kind_of Array
      @hotel_res.all_rooms[0].must_be_kind_of Hotel::Room
    end

    it 'creates all_reservations' do
      @hotel_res.all_reservations.must_be_kind_of Array
    end
  end

  describe 'make_reservation' do
    it 'creates a new reservation' do
      @res2.must_be_kind_of Hotel::Reservation
    end

    it 'adds a reservation to all_reservations' do
      @hotel_res.all_reservations[0].must_be_kind_of Hotel::Reservation
      @hotel_res.all_reservations.length.must_equal 2
    end
  end

  describe 'check_reserved' do
    it 'returns an array of rooms' do


      @hotel_res.check_reserved(@start_date, @end_date).must_be_kind_of Array
      @hotel_res.check_reserved(@start_date, @end_date)[0].must_be_kind_of Hotel::Room

    end

    it 'still works for the first reservation ever' do

    end
  end

  describe 'check_availability' do
    it 'returns an array of rooms' do
      @hotel_res.check_availability(@start_date, @end_date).must_be_kind_of Array
      @hotel_res.check_availability(@start_date, @end_date)[0].must_be_kind_of Hotel::Room
    end
  end
end
