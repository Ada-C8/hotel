require_relative 'spec_helper'

describe 'Block' do
before do
  @new_hotel = Hotel::Reservations.new
  @new_block = Hotel::Block.new("2018-01-01", "2018-01-10", [])
end
  describe 'initialize' do
    it "must be an instance of a Block" do
      @new_block.must_be_instance_of Hotel::Block
    end
  end

  describe 'dates' do
    it 'must have a list of dates' do
      @new_block.must_respond_to :date_range
    end
    it 'must be an array' do
      @new_block.dates.must_be_kind_of Array
    end
    it 'elements in the array must be of the date class' do
      @new_block.dates[0].must_be_kind_of Date
    end
  end

  describe 'has_rooms_available' do
    before do
      @new_block1 = Hotel::Block.new("2018-01-01", "2018-01-10", "Heritage", [1, 2, 3, 4, 5])
      @new_block1.booked = [1, 2, 3, 4]
    end
    it 'must return true when at least one room is available' do
      @new_block1.has_rooms_available?.must_equal true
    end
    it 'must return false when no rooms available' do
      @new_block1.booked << 5
      @new_block1.has_rooms_available?.must_equal false
    end
  end


end
