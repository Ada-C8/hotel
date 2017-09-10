require_relative 'spec_helper'

describe "Reservation" do

  let(:reservation) { BookingSystem::Reservation.new("Bob", 1, '2001-02-05', '2001-02-10') }

  describe "#initialize" do
    it "should create an instance of Reservation" do
      reservation.must_be_instance_of BookingSystem::Reservation

      reservation.must_respond_to :name
      reservation.name.must_be_kind_of String
      reservation.name.must_equal "Bob"

      reservation.must_respond_to :check_in
      reservation.check_in.must_be_instance_of Date

      reservation.must_respond_to :check_out
      reservation.check_out.must_be_instance_of Date

      reservation.must_respond_to :room_num
      reservation.room_num.must_be_kind_of Integer
      reservation.room_num.must_equal 1

      reservation.must_respond_to :total_cost
      reservation.total_cost.must_be_kind_of Integer
      reservation.total_cost.must_equal 1000
    end
  end # Describe

end # Describe
