require_relative 'spec_helper'

describe "BookingSystem" do
  describe "initialize" do
    it "creates an instance" do
      new_reservation =
      Hotel::BookingSystem.new
      new_reservation.must_be_instance_of Hotel::BookingSystem
    end

  end
end





#
# end #End of describe block
