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

    it "The list_of_rooms attribute that is an array of rooms" do
      @hotel.list_of_rooms.must_be_kind_of Array
      @hotel.list_of_rooms[0].must_be_kind_of Hotel::Room
      @hotel.list_of_rooms[0].number.must_equal 1
      @hotel.list_of_rooms[19].number.must_equal 20
      @hotel.list_of_rooms[20].must_be_nil
      @hotel.list_of_rooms[0].price.must_equal 200.00
    end

    it "has a make_reservation method" do
      @hotel.must_respond_to :make_reservation

    end

    it "has a reservations attribute" do
      @hotel.must_respond_to :reservations
    end

    it "The reservations attribute is an array of reservations" do
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.reservations.must_be_kind_of Array
      @hotel.reservations[0].client.must_equal "Marcel Luedtke"
      @hotel.reservations[0].stay_length.must_equal 2
    end

    it "The make_reservation method change the status of the rooms booked" do
      @hotel = Hotel::Hotel.new(20)
      @hotel.list_of_rooms[0].booked.must_equal false
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.list_of_rooms[0].booked.must_equal true
      @hotel.list_of_rooms[1].booked.must_equal false
      @hotel = Hotel::Hotel.new(20)
      @hotel.make_reservation("Walter luedtke", 2017,9,17, 2017,9,19, 3)
      @hotel.list_of_rooms[0].booked.must_equal true
      @hotel.list_of_rooms[1].booked.must_equal true
      @hotel.list_of_rooms[2].booked.must_equal true
      @hotel.list_of_rooms[3].booked.must_equal false
      @hotel.list_of_rooms[4].booked.must_equal false
      @hotel.list_of_rooms[5].booked.must_equal false
      @hotel.make_reservation("Alex luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.list_of_rooms[0].booked.must_equal true
      @hotel.list_of_rooms[1].booked.must_equal true
      @hotel.list_of_rooms[2].booked.must_equal true
      @hotel.list_of_rooms[3].booked.must_equal true
      @hotel.list_of_rooms[4].booked.must_equal false
      @hotel.list_of_rooms[5].booked.must_equal false
    end

    it "has a reservations_by_date method" do
      @hotel = Hotel::Hotel.new(20)
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.must_respond_to :reservations_by_date

    end
  end

end
