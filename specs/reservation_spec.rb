require_relative 'spec_helper'

describe 'Reservation' do
  before do
    check_in = Date.new(2017,9,5)
    check_out = Date.new(2017,9,7)
    @my_reservation = Hotel_System::Reservation.new(check_in, check_out)
  end
  describe '#initialize' do
    it "takes a name, a check_in date, and a check_out date as parameters" do
      @my_reservation.must_be_instance_of Hotel_System::Reservation
    end
  end
  describe '#cost' do
    it 'calculates the cost of the reservation' do
      @my_reservation.cost.must_equal 400
    end
  end
end
