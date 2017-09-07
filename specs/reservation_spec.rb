require_relative 'spec_helper'

describe "Reservation" do

  before do
    date = Date.new(2017,2,12)
    @new_res = ReservationSystem::Reservation.new(date, 9)
  end # before

  describe "initialize" do
    it "Creates a Reservation with a check-in date, a room, a number of nights and a list of dates reserved" do

      @new_res.must_be_instance_of ReservationSystem::Reservation

      @new_res.check_in.must_be_kind_of Date
      @new_res.check_in.must_equal Date.new(2017,2,12)

      @new_res.nights.must_be_kind_of Integer
      @new_res.nights.must_equal 9

      @new_res.dates_reserved.must_be_kind_of Array
      @new_res.dates_reserved.length.must_equal 9
      @new_res.dates_reserved[0].must_equal Date.new(2017,2,12)
      @new_res.dates_reserved[-1].must_equal Date.new(2017,2,12) + 8
      @new_res.dates_reserved.wont_include Date.new(2017,2,11)
      @new_res.dates_reserved.wont_include Date.new(2017,2,21)
    end
  end # "initialize"

end # "Reservation"

#============== OLD WORK ====================#
