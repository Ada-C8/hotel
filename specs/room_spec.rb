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
      Hotel::Room.rooms_available.length # 20
      @puppy_room.assign_room # 1
      Hotel::Room.rooms_available.length.must_equal 19
    end # end test

    it 'assigns a different room number as they are assigned and made unavailable' do
      @puppy_room.assign_room # 1
      @kitten_room = Hotel::Room.new
      @kitten_room.assign_room # 2
      @bat_room = Hotel::Room.new
      @bat_room.assign_room.must_equal 3

    end # end test
  end # end assign_room
end # end all Room tests
