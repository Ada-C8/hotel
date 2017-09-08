require_relative 'spec_helper'

describe 'Room' do
  before do
    @room = Hotel::Room.new(5, 200)
  end
  describe 'initialize' do
    it 'can be instantiated' do
      @room.must_be_kind_of Hotel::Room
    end

    it 'has a room number' do
      @room.number.must_equal 5
    end

    it 'has a cost' do
      @room.cost.must_equal 200
    end

    describe 'comparable' do
      it 'is equivalent to another room with the same number' do
        room2 = Hotel::Room.new(5, 200)
        (@room == room2).must_equal true
      end
    end
  end
end
