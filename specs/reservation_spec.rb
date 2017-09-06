#reservation_spec.rb

require_relative 'spec_helper.rb'

describe "Reservation Class" do

  describe "Initializing the Reservation Class" do

    it "can be initialized" do
      reservation = Hotel_Chain::Reservation.new((2017), (2017))
      reservation.class.must_be_kind_of Class

    end

    it "creates a room object and assigns it to the reservation" do
      reservation = Hotel_Chain::Reservation.new((2017), (2017))
      reservation.room_id.must_be_kind_of Integer

    end
    #
    # it "can reserve a room for a given date" do
    #
    # end

  end

end
