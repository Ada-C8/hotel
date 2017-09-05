#hotel_spec.rb
require_relative 'spec_helper.rb'
describe "The Hotel class" do

  describe "Initializing the Hotel" do

    it "can be initialized" do
      @myhotel = Hotel_Chain::MyHotel.new(5)
      @myhotel.class.must_be_kind_of Class
      @myhotel.no_of_rooms.must_equal 5
      @myhotel.no_of_rooms.must_be_kind_of Integer
    end

  # describe "Self.std_rate_hotel method" do
  #
  #   it "The hotel contains 20 room objects" do
  #     @room_roster = Hotel_Chain::Hotel.std_rate_hotel(20)
  #     @room_roster.length.must_equal 20
  #   end
  #
  #   it "Room roster must be instance of Hotel::Room" do
  #     @room_roster = Hotel_Chain::Room.all
  #     @room_roster[0].must_be_instance_of Hotel::Room
  #   end
  #
  #   it "Room roster is an array of room objects" do
  #     @room_roster = Hotel_Chain::Room.all
  #     @room_roster.must_be_kind_of Array
  #   end
  # end

  end



end
