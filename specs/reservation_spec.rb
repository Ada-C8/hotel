#reservation_spec.rb
require 'date'

require_relative 'spec_helper.rb'

describe "Reservation Class" do

  describe "Initializing the Reservation Class" do

    before do
      check_in_date = "8/13/17"
      check_out_date = "8/16/17"
      @reservation = Hotel_Chain::Reservation.new(check_in_date, check_out_date)
    end

    it "can be initialized" do
      @reservation.class.must_be_kind_of Class
    end

    it "creates a room object and assigns it to the reservation" do
      @reservation.room_id.must_be_kind_of Integer
    end

    it "a reservation has a check-in date" do
      @reservation.check_in_date.must_be_kind_of Date
    end
    #
    # it "can reserve a room for a given date" do
    #
    # end

  end

end
