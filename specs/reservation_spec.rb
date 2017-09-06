require_relative 'spec_helper'
require 'date'

describe "Reservaton Class" do
  describe "Can reserve a room for any given date range" do

  it "Should be an instance of a Reservation" do
    name = "Marisa"
    check_in_date = Date.new(2017,9,5)
    check_out_date = Date.new(2017,9,10)

    reservation1 = HotelManagment::Reservation.new(name, check_in_date, check_out_date)
    reservation1.must_be_instance_of HotelManagment::Reservation
  end

  it "text" do

  end

end
end


# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
