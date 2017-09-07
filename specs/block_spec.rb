require_relative 'spec_helper'

describe 'Block' do
  before do
    # - To create a block you need a date range, collection of rooms and a discounted room rate
    @block = Hotel::Block.new('2017-08-03', '2017-08-07', 5, 20)
  end

  it 'can be instantiated' do
    @block.must_be_kind_of Hotel::Block
  end
end
