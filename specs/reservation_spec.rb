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
    end # it

  end #describe

  describe " #total_cost" do
    before do
      @hotel = Hotel::Reservation.new('sept 7 2017', 'sept 9 2017', 18)
    end

    it "Can be called" do
      @hotel.total_cost.must_equal 400
    end
  end

end #describe
