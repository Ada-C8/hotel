require_relative 'spec_helper'

describe 'Hotel' do
  describe '#initialize' do
    before do
      @my_hotel = Hotel_System::Hotel.new(20)
    end
    it 'takes number of rooms as a parameter when initialized' do
      @my_hotel.number_of_rooms.must_equal 20
    end
    it 'creates an array of room objects when initialized' do
      @my_hotel.rooms.must_be_instance_of Array
      @my_hotel.rooms.each { |room| room.must_be_instance_of Hotel_System::Room }
    end
  end
end
