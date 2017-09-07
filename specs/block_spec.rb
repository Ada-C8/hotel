require_relative 'spec_helper'

describe 'Block' do
  describe 'initialize' do
    it 'is initialized with a check_in date, check_out date, rooms, and a rate adjustor' do
      check_in = Date.new(2017,9,5)
      check_out = Date.new(2017,9,7)
      rooms = [Hotel_System::Room.new(1)]
      rate_adjustor = 0.75
      @my_block = Hotel_System::Block.new(check_in, check_out, rooms, rate_adjustor)

      @my_block.must_be_instance_of Hotel_System::Block
      @my_block.check_in.must_equal check_in
      @my_block.check_out.must_equal check_out
      @my_block.rooms.must_equal rooms
      @my_block.rate_adjustor.must_equal rate_adjustor
    end
  end
end
