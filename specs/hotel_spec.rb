require_relative 'spec_helper'

describe 'Hotel' do
  before do
    @hotel = Hotel::Hotel.new
  end
  describe 'initialize' do
    it 'creates an instance of Hotel' do
      @hotel.must_be_instance_of Hotel::Hotel
    end

    it 'creates a hash of rooms' do
      @hotel.rooms.must_be_kind_of Hash
    end

    it 'creates an array of reservations' do
      @hotel.reservations.must_be_kind_of Array
    end

  end

  # describe 'view available' do
  #   it 'returns a list of rooms that are available for a given date' do
  #     @hotel.view_available(1).must_respond_to :date_range
  #     @hotel.view_available(1).must_be_kind_of Array
  #   end
  # end
end
