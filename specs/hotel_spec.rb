require_relative 'spec_helper'

describe 'Hotel' do
  it 'takes number of rooms as a parameter when initialized' do
    my_hotel = Hotel_System::Hotel.new(20)
  end
end
