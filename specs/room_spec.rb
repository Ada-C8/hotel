require_relative 'spec_helper'

describe 'Room' do
  before do
    @puppy_room = Hotel::Room.new(13)
  end # end before

  describe 'initialize' do
    it 'creates an instance of Room' do
      @puppy_room.class.must_equal Hotel::Room
    end # end test
  end # end #initialize

  describe 'assign_room' do
    xit 'assigns a room number from the rooms_available ARRAY' do
      @puppy_room.assign_room.must_equal rooms_available[0]
    end # end test

    xit 'room_number = its matching index (room_number minus 1) in rooms_available array' do
      @puppy_room.assign_room.must_equal Hotel::Room::rooms_available[13-1]
    end # end test
  end # end assign_room
end # end all Room tests
