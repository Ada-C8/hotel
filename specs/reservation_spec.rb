require_relative 'spec_helper'


describe "Reservation class" do

  describe "Initialization" do
    before do
      @hotel = Hotel::Reservation.new('sept 7 2017', 'sept 9 2017', 18)
    end

    it "Can be intialized" do
      @hotel.must_be_instance_of Hotel::Reservation
    end

    it "Can call on instance variables" do
      @hotel.date_range.must_be_instance_of Hotel::DateRange #important - need to include Hotel::DateRange; cannot be DateRange alone
      @hotel.room_num.must_equal 18
      @hotel.cost.must_equal 200
      @hotel.reservation_array.must_include 200
      @hotel.reservation_array.must_be_instance_of Array
      @hotel.reservation_array.length.must_equal 3 ##note, I thought here it should be 4, but daterange is one instance so check_in and check_out exist together as daterange instance
    end # it

  end #describe

  describe " #total_cost" do
    before do
      @hotel = Hotel::Reservation.new('sept 7 2017', 'sept 9 2017', 18)
      @hotel_2 = Hotel::Reservation.new('oct 22 2017', 'oct 28 2017', 20)
    end

    it "Can be called" do
      @hotel.total_cost.must_equal 400
      @hotel_2.total_cost.must_equal 1200
    end
  end

end #describe
