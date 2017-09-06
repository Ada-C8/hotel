require_relative 'spec_helper'

describe 'Reservation' do
  before do
    @reservation = Hotel::Reservation.new(1, '2017-09-05', '2017-09-07')
  end

  describe '#initialize' do
    it 'can be instantiated' do
      @reservation.must_be_kind_of Hotel::Reservation
    end

    it 'has @dates value, which is array of dates' do
      @reservation.dates.must_be_kind_of Array
      @reservation.dates.first.must_be_kind_of Date
    end

    it 'has 8-digit @reservation_id value where first 4 digits are checkin date' do
      @reservation.id.must_be_kind_of String
      @reservation.id.length.must_equal 8
      @reservation.id[0..3].must_equal "0905"
    end
    
    it 'has @total_cost value, which is rate * num of nights' do
      @reservation.total_cost.must_equal 400
      (@reservation.total_cost % @reservation.dates.length).must_equal 0
    end
  end
end
