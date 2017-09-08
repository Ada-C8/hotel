require_relative 'spec_helper'

describe "Administration#Reservation" do

  describe "instantiate a reservation" do
    it "has a check_in and check out date" do
      check_in = Date.new(2017, 8, 30)
      check_out = Date.new(2017, 9, 5)
      reservation = Administration::Reservation.new(check_in, check_out)

      reservation.must_respond_to :check_in
      reservation.check_in.must_equal check_in
      reservation.check_in.must_be_kind_of Date
end



  end #end of reservation wave 1

end #end of module
