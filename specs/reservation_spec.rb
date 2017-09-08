require_relative 'spec_helper'
require 'date'
require 'pry'
describe 'Reservation' do
  before do
    @reservation = Hotel::Reservation.new(1, :room4, 200, Date.new(2018,9,12), Date.new(2018,9,15))
    @reservation_for_one = Hotel::Reservation.new(1, :room4, 200, Date.new(2018,9,12))
    # Hotel::Hotel.new
  end
  describe 'initialize' do
    it 'must be type of reservation' do
      @reservation.must_be_instance_of Hotel::Reservation
    end

    it 'must respond to id, date1, date2, room_number' do
      @reservation.must_respond_to :id
      @reservation.must_respond_to :date1
      @reservation.must_respond_to :date2
      @reservation.must_respond_to :room_number
      @reservation.must_respond_to :cost

    end

    it 'must create a daterange for two dates upon intialization' do
      @reservation.daterange.must_be_instance_of Hotel::DateRange
    end

    it 'must create a daterange for one date upon intialization' do
      @reservation_for_one.daterange.must_be_instance_of Hotel::DateRange
    end

  end

  describe 'get_cost' do
    it 'must return the correct cost for one night' do
      @reservation_for_one.get_cost.must_equal 200
    end
    it 'must return the correct cost for multinight stay' do
      # binding.pry
      puts "NUMBER DAYS: #{@reservation.daterange.number_days}"
      res = Hotel::Reservation.new(1, :room5, 200, Date.new(2018,11,11), Date.new(2018,11,16))
      res.get_cost.must_equal 1200
    end

  end
end
