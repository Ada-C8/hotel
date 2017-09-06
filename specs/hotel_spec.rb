require_relative 'spec_helper.rb'

describe "Hotel" do

  before do
    @hotel = Hotel::Hotel.new(20)
  end

  describe "Hotel class" do

    it "is a class of the Hotel module" do
      Hotel::Hotel.class.must_equal Class
    end

    it "takes a readable number_of_rooms attribute " do
      @hotel.must_respond_to :number_of_rooms
      @hotel.number_of_rooms.must_equal 20
    end

    it "has a list_of_rooms attribute" do
      @hotel.must_respond_to :list_of_rooms
    end

    it "has a list_of_rooms attribute that is an array of rooms" do
      @hotel.list_of_rooms.must_be_kind_of Array
      @hotel.list_of_rooms[0].must_be_kind_of Hotel::Room
      @hotel.list_of_rooms[0].number.must_equal 1
      @hotel.list_of_rooms[19].number.must_equal 20
      @hotel.list_of_rooms[20].must_be_nil
      @hotel.list_of_rooms[0].price.must_equal 200.00
    end
  end

end
