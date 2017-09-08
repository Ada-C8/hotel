require_relative 'spec_helper'

describe 'Reservation' do
  let(:check_in) {Date.new(2017,9,5)}
  let(:check_out) {Date.new(2017,9,7)}
  let(:my_reservation) {Hotel_System::Reservation.new(check_in, check_out)}

  describe '#initialize' do
    it "creates a new instance of Reservation" do
      my_reservation.must_be_instance_of Hotel_System::Reservation
    end
    it "raises an argument error unless passed Date objects" do
      proc {Hotel_System::Reservation.new("today", "tomorrow")}.must_raise ArgumentError
    end
    it "raises an argument error if check_out is same as or before check_in" do
      proc {Hotel_System::Reservation.new(check_in, check_in)}.must_raise ArgumentError
      proc {Hotel_System::Reservation.new(check_out, check_in)}.must_raise ArgumentError
    end
  end
  describe '#cost' do
    it 'calculates the cost of the reservation' do
      my_reservation.cost.must_equal 400
    end
  end
end
