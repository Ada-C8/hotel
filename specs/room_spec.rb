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

    it 'assigns room number and not index number' do
      @puppy_room.assign_room
      @puppy_room.assign_room
      @puppy_room.assign_room.must_equal 3

      ####################################
      # okay so in this test, i want it to change the room number as they are booked. so #assign_room is called 3 times, room number should be 3. BUT, what is happening, is it's the SAME GUEST booking 3 rooms. if i make a new instance of Hotel::Room, obv it'll just reset the array and the room assigned would be 1. how do????)
      #####################################
      
    end # end test
  end # end assign_room
end # end all Room tests
