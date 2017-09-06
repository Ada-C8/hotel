#hotel_spec.rb
require_relative 'spec_helper.rb'
describe "The Hotel class" do

  describe "Initializing the Hotel" do

    it "can be initialized" do
      myhotel = Hotel_Chain::MyHotel.new
      myhotel.class.must_be_kind_of Class
    end

    it "The hotel can be initialized with a set number of room objects" do
      myhotel = Hotel_Chain::MyHotel.new
      myhotel.array_of_rooms.length.must_equal 20
    end

    it "Returns an array" do
      myhotel = Hotel_Chain::MyHotel.new
      myhotel.array_of_rooms.must_be_kind_of Array
    end

    # it "Hotel object contains an array of room objects" do
    #   hotel = Hotel_Chain::MyHotel.new
    #   hotel.list_of_rooms[0].must_be_instance_of Hotel_Chain::Room
    # end

  end

  describe "list_of_rooms method" do

    it "Prints a statement to the user" do
      myhotel = Hotel_Chain::MyHotel.new
      proc {myhotel.list_rooms}.wont_be_nil
    end

    it "Returns an array with length 20" do
      myhotel = Hotel_Chain::MyHotel.new
      myhotel.list_rooms.length.must_equal 20

    end

    it "gives expected statement at 0 position" do
      myhotel = Hotel_Chain::MyHotel.new
      myhotel.list_rooms[0].must_equal "1. Room 1 - $200/night"
    end


  end

end
