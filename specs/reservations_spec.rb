require_relative 'spec_helper'


describe "Hotel" do
  describe "Reservations" do

    before do
    @hotel1 = Hotel::Reservations.new
    checkin = Date.new(2017,9,5)
    checkout = Date.new(20117,9,7)
    @res2 = Hotel::Booking.new(checkin, checkout, #need to make rooms, id)
    @res3 = Hotel::Booking.new(checkin, checkout, rooms, id)
    @res4 = Hotel::Booking.new(checkin, checkout, rooms, id)
    @hotel1.all_reservations = [@res2, @res3, @res4]
    end



# errors that that admin could mess up:

# it "before a reservation can be made, it checks availablity" do
#   # @res1.must_be_instance_of Hotel::Reservations
# end

# it "must check if date range is available" do
#   res1.check_reservation
# end

# it "if we have availability, it creates a reservation" do
#
# end
#
# it "all_reservations is an array of all reservations" do
#
# end
#
#
# it "reservation is pushed into all_reservations array" do
#
# end




  end
end
