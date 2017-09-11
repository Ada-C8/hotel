require_relative 'spec_helper'

describe 'Room' do
  before do
    @room = Hotels::Room.new(5)
  end

  describe '#initialize' do
    it 'Can be initialized' do
      @room.must_be_instance_of Hotels::Room
    end
    it 'Has an ID number' do
      assert_equal 5, @room.room_id
    end
    it 'Has a rate for regular reservation nights' do
      Hotels::Room::REGULAR_RATE.must_be_kind_of Integer
    end
    it 'Has a rate for block reservation nights' do
      Hotels::Room::BLOCK_RATE.must_be_kind_of Integer
    end
  end # ------------------------- describe #initialize block
end
