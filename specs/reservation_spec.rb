#reservation_spec.rb

require_relative 'spec_helper.rb'

describe "Reservation Class" do

  describe "Initializing the Reservation Class" do

    it "can be initialized" do
      Hotel_Chain::Reservation.new((2017), (2017))
    end

  end

end
