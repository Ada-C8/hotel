require_relative 'spec_helper'

describe 'Room' do
  before do
    ############################
    Hotel::Room.initialize_rooms
    ############################
    @puppy_room = Hotel::Room.new
    @kitten_room = Hotel::Room.new
    @bat_room = Hotel::Room.new
  end # end before

  describe 'initialize' do
    it 'creates an instance of Room' do
      @puppy_room.class.must_equal Hotel::Room
    end # end test
  end # end #initialize

  describe 'assign_room' do
    it 'removes unavailable rooms from the rooms_available array each time a room is booked' do
      Hotel::Room.rooms_available.length # 20
      @puppy_room.assign_room # -1
      @kitten_room.assign_room # -1
      Hotel::Room.rooms_available.length.must_equal 18
    end # end test

    it 'assigns a different room number as they are assigned and made unavailable' do
      @puppy_room.assign_room # room 1
      @kitten_room.assign_room # room 2
      @bat_room.assign_room # room 3
      @bat_room.room_number.must_equal 3
    end # end test
  end # end assign_room

  describe 'check_out_of_room' do
    it 'returns the room number to the rooms_available array when a guest checks out' do
      @puppy_room.assign_room # room 1
      @kitten_room.assign_room # room 2
      @puppy_room.check_out_of_room # return 1 to array

      Hotel::Room.rooms_available.must_include 1
    end # end test

    it 'will sort the rooms_available array each time a room is assigned so the remaining rooms are in order (this will help when consecutive rooms need to be booked together)' do
      @puppy_room.assign_room # room 1
      @kitten_room.assign_room # room 2
      @bat_room.assign_room # room 3
      @puppy_room.check_out_of_room # room 1
      @kitten_room.check_out_of_room # room 2
      @bat_room.check_out_of_room # room 3

      Hotel::Room.rooms_available.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    end # end test
  end # end #check_out_of_room
end # end all Room tests
