require_relative './spec_helper'
require_relative '../lib/block'


describe '#BLOCKS' do
  before do
    @new_block = Block.new("January 5, 2018", "January 8, 2018", [Room.new(2, 200), Room.new(3, 150)], 0.8)
  end

  describe 'block' do
    it 'Can create an instance of block' do
      @new_block.must_be_instance_of Block
    end

    it 'Has rooms' do
      @numbers = []
      @new_block.rooms.each do |room|
        @numbers.push(room.number)
      end

      @numbers.must_equal [2, 3]
    end

    it 'Will not accept a block of more than 5 rooms' do
      proc {Block.new("January 5, 2018", "January 8, 2018", [Room.new(2, 200), Room.new(3, 150), Room.new(4, 150), Room.new(5, 150), Room.new(6, 150), Room.new(7, 150)], 0.8)}.must_raise ArgumentError
    end


  describe '#make_reservation' do
    it 'can add a reservation to a block' do
      @new_block.make_reservation([2, 3])
      @new_block.reservations.length.must_equal 1;
      @new_block.reservations.first.rooms.length.must_equal 2;
    end
  end

  end



end
