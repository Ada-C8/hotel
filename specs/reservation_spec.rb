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

    # it 'has 9-character @id value' do
    #   @reservation.id.must_be_kind_of String
    #   @reservation.id.length.must_equal 9
    #   @reservation.id[0..4].must_equal 'R0905'
    # end

    it 'has @total_cost value, which is rate * num of nights' do
      # As an administrator, I can get the total cost for a given reservation
      @reservation.total_cost.must_equal 400
      (@reservation.total_cost % @reservation.dates.length).must_equal 0
    end

    #TODO: @total_cost for blocks
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
  end
end
