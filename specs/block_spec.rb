require_relative 'spec_helper'

describe 'Block' do
  let(:check_in) {Date.new(2017,9,5)}
  let(:check_out) {Date.new(2017,9,7)}
  let(:rooms) {[Hotel_System::Room.new(1)]}
  let(:rate_adjustor) {0.75}
  let(:my_block) {Hotel_System::Block.new(check_in, check_out, rooms, rate_adjustor)}

  describe 'initialize' do
    it 'is initialized with a check_in date, check_out date, rooms, and a rate adjustor' do
      my_block.must_be_instance_of Hotel_System::Block
      my_block.check_in.must_equal check_in
      my_block.check_out.must_equal check_out
      my_block.rooms.must_equal rooms
      my_block.rate_adjustor.must_equal rate_adjustor
    end
  end

  describe 'block_reserve' do
    it 'adds a room to a list of reservations within the block' do
        my_block.reserve_in_block.must_be_instance_of Array
        my_block.rooms_reserved_in_block.each {|room| room.must_be_instance_of Hotel_System::Room}
    end

    it 'does not allow you to reserve a room if all rooms in block are already reserved' do
      my_block.reserve_in_block
      proc {my_block.reserve_in_block}.must_raise StandardError
    end
  end

  describe 'find_avail_rooms' do
    it 'lists all rooms available within the block' do
      my_block.find_avail_rooms.must_be_instance_of Array
      my_block.find_avail_rooms.length.must_equal 1
      my_block.reserve_in_block
      my_block.find_avail_rooms.length.must_equal 0
    end
  end
end
