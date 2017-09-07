require_relative 'spec_helper'

describe 'Room' do
  before do
    @puppy_room = Hotel::Room.new
  end # end before

  describe 'initialize' do
    it 'creates an instance of Room' do
      @puppy_room.class.must_equal Hotel::Room
    end # end test
  end # end #initialize

  describe 'assign_room' do
    it 'removes unavailable rooms from the rooms_available array each time a room is booked' do
      @puppy_room.rooms_available.length
      @puppy_room.assign_room
      @puppy_room.rooms_available.length.must_equal 19
    end # end test

    xit 'assigns a room number from the rooms_available ARRAY' do
      @puppy_room.assign_room.must_equal rooms_available[0]
    end # end test
  end # end assign_room
end # end all Room tests
