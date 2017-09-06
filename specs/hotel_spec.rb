#hotel_spec.rb
require_relative 'spec_helper.rb'
describe "The Hotel class" do

  describe "Initializing the Hotel" do

    it "can be initialized" do
      @myhotel = Hotel_Chain::MyHotel.new
      @myhotel.class.must_be_kind_of Class
      @myhotel.no_of_rooms.must_equal nil
    end

  end

  describe "Self.std_rate_hotel method" do

    it "The hotel contains 20 room objects" do
      @myhotel = Hotel_Chain::MyHotel
      @myhotel.all(20).length.must_equal 20
    end

    it "Room roster is an array of room objects" do
      @myhotel = Hotel_Chain::MyHotel.all(20)
      @myhotel.must_be_kind_of Array
    end
  end

end
