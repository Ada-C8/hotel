require 'date'
require_relative 'spec_helper'


describe "Reservation" do
  before do
    first_name = "Jane"
    last_name = "Doe"
    room_id = 1
    room_rate = 200.00
    reserv_id = 1221
    start_date = Date.parse("1/9/2017")
    end_date = Date.parse("3/9/2017")
    room_count = 1
    total_cost = 0
    @reservation_test = BookingSystem::Reservation.new(first_name, last_name, room_id, room_rate, reserv_id, start_date, end_date, room_count, total_cost)
  end

  describe "#initialize" do
    it "can create an instance of Reservation class" do
      @reservation_test.class.must_equal BookingSystem::Reservation
    end

    it "can take in reserver's identity info as arguments: first_name, last_name" do
      #@reservation_test.must_respond_to(first_name) #? not sure why this gives an error
      @reservation_test.first_name.must_equal("Jane")
      @reservation_test.first_name.must_be_instance_of String

      @reservation_test.last_name.must_equal("Doe")
      @reservation_test.last_name.must_be_instance_of String
    end

    it "can take in room info as arguments: room_id, room_rate" do
      @reservation_test.room_id.must_equal 1
      @reservation_test.room_id.must_be_instance_of Integer

      @reservation_test.room_rate.must_equal 200.00
      @reservation_test.room_rate.must_be_instance_of Float
    end

    it "#reserv_id: can give correct reservation id number" do
      @reservation_test.reserv_id.must_equal 1221
    end

    # it "#total_cost: can give correct cost" do
    #   @reservation_test.total_cost.must_equal 400
    # end
  end

  # describe "#get_total_cost" do
  #   it "can calculate a total " do
  #
  #   end
  # end

end#of_"Reservation"
