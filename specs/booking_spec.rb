# require 'pry'
require_relative 'spec_helper'

describe 'Booking class' do
  before do
    start_date = Date.new(2017,9,1)
    end_date = Date.new(2017,9,3)
    @date_range = Hotel::DateRange.new(start_date, end_date)
    @room = Hotel::Room.new(1)
    @booking1 = Hotel::Booking.new(1, [@room], @date_range)
  end
  describe 'initialize' do
    it 'can be instantiated' do
      @booking1.must_be_kind_of Hotel::Booking
    end

    it 'creates a DateRange for the booking' do
      @booking1.date_range.must_be_kind_of Hotel::DateRange
    end

    it 'creates an ID number' do
      @booking1.id.must_equal 1
    end

    it 'has a total_cost' do
      @booking1.total_cost.must_equal 200
    end

  end


end
