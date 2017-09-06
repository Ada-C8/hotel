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

    it 'has @total_cost value' do
      @reservation.total_cost.must_equal 400
    end
  end
end
