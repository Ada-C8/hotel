require_relative 'spec_helper'

describe 'Block' do
  before do
    # - To create a block you need a date range, collection of rooms and a discounted room rate
    @block = Hotel::Block.new('2017-08-03', '2017-08-07', 5, 20)
  end

  it 'can be instantiated' do
    @block.must_be_kind_of Hotel::Block
  end

  it 'has 9-character @id value' do
    @block.id.must_be_kind_of String
    @block.id.length.must_equal 9
    @block.id[0..4].must_equal 'B0803'
  end
end
