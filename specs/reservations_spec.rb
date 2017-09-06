require_relative '../lib/reservation'
require_relative 'spec_helper'

describe "reservation" do

  it "can initialize a reservation" do
    reservation_1 = Hotel::Reservation.new( [1,2,3], 4, "T Payne", "8675309" )
    reservation_1.must_be_instance_of Hotel::Reservation
  end

  it "can return the correct information" do
    reservation_1 = Hotel::Reservation.new( [1,2,3], 4, "Mary Shelley", "8675309" )
    reservation_1.date_range.must_equal [1, 2, 3]
    reservation_1.room.must_equal 4
    reservation_1.name.must_equal "Mary Shelley"
    reservation_1.contact_info.must_equal "8675309"
    reservation_1.price.must_equal 600
  end
end

describe "dates method" do
  it "can get dates from reservation" do
    reservation_1 = Hotel::Reservation.new( [1,2,3], 4, "Dr. Frankenstein", "8675309" )
    range_dates = reservation_1.dates
    puts range_dates[0]
    range_dates[0].must_equal 1
  end
end
