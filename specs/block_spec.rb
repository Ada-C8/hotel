require_relative 'spec_helper'

describe 'make_block' do
  before do
    start_date = Date.new(2017,9,1)
    end_date = Date.new(2017,9,3)
    date_range = Hotel::DateRange.new(start_date, end_date)
    room = Hotel::Room.new(1)
    block_id = 3

    @block1 = Hotel::Block.new(1, [room], date_range, block_id)
  end
  it 'can be instantiated' do
    @block1.must_be_kind_of Hotel::Block
    @block1.must_be_kind_of Hotel::Booking
  end

end
