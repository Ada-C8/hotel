require_relative 'spec_helper'

describe 'Hotel' do
  before do
    @my_hotel = Hotel_System::Hotel.new(20)
  end
  describe '#initialize' do
    it 'takes number of rooms as a parameter when initialized' do
      @my_hotel.number_of_rooms.must_equal 20
    end
    it 'creates an array of room objects when initialized' do
      @my_hotel.rooms.must_be_instance_of Array
      @my_hotel.rooms.each { |room| room.must_be_instance_of Hotel_System::Room }
    end
    it 'creates an empty collection of reservations' do
      @my_hotel.reservations.must_be_instance_of Array
    end
  end
  describe 'reservations' do
    it "combines room reservation arrays into an array of all hotel reservations" do
      check_in = Date.new(2017,9,5)
      check_out = Date.new(2017,9,7)
      @my_hotel.rooms[1].reserve(check_in, check_out)
      @my_hotel.reservations.length.must_equal 1

      @my_hotel.rooms[19].reserve(check_in, check_out)
      @my_hotel.reservations.length.must_equal 2
    end
  end
  describe '#find_res_by_date' do
    it "returns an array of reservations whose duration includes given date" do
      check_in = Date.new(2017,9,5)
      check_out = Date.new(2017,9,7)
      @my_hotel.rooms[1].reserve(check_in, check_out)
      @my_hotel.rooms[19].reserve(check_in, check_out)
      date_to_find = Date.new(2017,9,6)
      birthday = Date.new(1991,7,19)
      date_outta_range = Date.new(2017,9,7)
      @my_hotel.find_res_by_date(date_to_find).must_be_instance_of Array
      @my_hotel.find_res_by_date(date_to_find).length.must_equal 2
      @my_hotel.find_res_by_date(date_outta_range).must_equal []
      @my_hotel.find_res_by_date(birthday).must_equal []
    end
  end
end
