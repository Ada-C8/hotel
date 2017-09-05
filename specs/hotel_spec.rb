require_relative 'spec_helper'

describe 'Hotel' do
  before do
    @hotel = Hotel::Hotel.new
  end
  describe 'initialize' do
    it 'creates an instance of Hotel' do
      @hotel.must_be_instance_of Hotel::Hotel
    end
  end
end
