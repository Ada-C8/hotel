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
      @new_block.date_range.must_be_kind_of Array
    end
    it 'elements in the array must be of the date class' do
      @new_block.date_range[0].must_be_kind_of Date
    end
  end



end
