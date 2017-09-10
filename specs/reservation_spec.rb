require_relative 'spec_helper'

describe 'Reservation' do
  before do
    @hotel = Hotel::Hotel.new(20)
    @room = @hotel.rooms[0]
    @reservation = Hotel::Reservation.new(@room, '2017-09-05', '2017-09-07', @hotel)
  end

  describe '#initialize' do
    it 'can be instantiated' do
      @reservation.must_be_kind_of Hotel::Reservation
    end

    it 'has @dates value, which is array of dates' do
      @reservation.dates.must_be_kind_of Array
      @reservation.dates.first.must_be_kind_of Date
    end

    it 'has @total_cost value, which is rate * num of nights' do
      # As an administrator, I can get the total cost for a given reservation
      @reservation.total_cost.must_equal 400
      (@reservation.total_cost % @reservation.dates.length).must_equal 0
    end

    it 'can be initialized with various date formats (Date or String)' do
      date1 = Date.new(2017, 9, 5)
      date2 = Date.new(2017, 9, 10)
      Hotel::Reservation.new(@room, date1, date2, @hotel)
      Hotel::Reservation.new(@room, '2017-09-05', '2017-09-10', @hotel)
      Hotel::Reservation.new(@room, 'September 5th, 2017', 'September 10th, 2017', @hotel)
      Hotel::Reservation.new(@room, '5/9/17', '10/9/17, 2017', @hotel)
    end

    it 'raises DatesError if dates are out of order' do
      proc {
        Hotel::Reservation.new(@room, '2017-09-15', '2017-09-07', @hotel)
      }.must_raise DatesError
    end

    it 'raises DatesError if dates do not span at least 1 night' do
      proc {
        Hotel::Reservation.new(@room, '2017-09-05', '2017-09-05', @hotel)
      }.must_raise DatesError


    end

    it 'raises ArgumentError if passed invalid dates' do
      proc {
        Hotel::Reservation.new(@room, 'sea', 'HAWKS', @hotel)
      }.must_raise ArgumentError
    end
  end

  describe 'get_total' do
    it 'factors block discount into total if part of block' do
      block = @hotel.make_block('2017-08-03', '2017-08-08', 10, 25)
      reservation = @hotel.make_reservation('2017-08-03', '2017-08-08', block.id)
      reservation.total_cost.must_equal 750
    end

    it 'returns total without discount if not part of block' do
      @reservation.total_cost.must_equal 400
    end

    it 'can have 0% (no) discount in block' do
        block = @hotel.make_block('2017-08-03', '2017-08-08', 10, 0)
        reservation = @hotel.make_reservation('2017-08-03', '2017-08-08', block.id)
        reservation.total_cost.must_equal 1000
    end

    it 'can have 100% (gratis) discount in block' do
        block = @hotel.make_block('2017-08-03', '2017-08-08', 10, 100)
        reservation = @hotel.make_reservation('2017-08-03', '2017-08-08', block.id)
        reservation.total_cost.must_equal 0
    end

    it 'can have float as discount in block' do
        block = @hotel.make_block('2017-08-03', '2017-08-08', 10, 12.5)
        reservation = @hotel.make_reservation('2017-08-03', '2017-08-08', block.id)
        reservation.total_cost.must_equal 875
    end

    it 'defaults to 0% (no) discount' do
        block = @hotel.make_block('2017-08-03', '2017-08-08', 10)
        reservation = @hotel.make_reservation('2017-08-03', '2017-08-08', block.id)
        reservation.total_cost.must_equal 1000
    end
  end

  describe '#includes_dates?' do
    it 'returns true if provided date range overlaps' do
      overlap = @reservation.includes_dates?('2017-09-06', '2017-09-07')
      overlap.must_equal true
    end

    it 'returns false if provided date range does not overlap' do
      overlap = @reservation.includes_dates?('2017-10-14', '2017-10-15')
      overlap.must_equal false
    end

    it 'returns true for partial overlap' do
      overlap = @reservation.includes_dates?('2017-09-06', '2017-09-20')
      overlap.must_equal true
    end

    it 'raises DatesError if dates are out of order' do
      proc {
        @reservation.includes_dates?('2017-09-15', '2017-09-07')
      }.must_raise DatesError
    end

    it 'raises DatesError if dates do not span at least 1 night' do
      proc {
        @reservation.includes_dates?('2017-09-05', '2017-09-05')
      }.must_raise DatesError
    end

    it 'raises ArgumentError if passed invalid dates' do
      proc {
        @reservation.includes_dates?('sea', 'HAWKS')
      }.must_raise ArgumentError
    end
  end
end
