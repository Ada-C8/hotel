require_relative 'spec_helper'

describe 'Block' do
  before do
    # - To create a block you need a date range, collection of rooms and a discounted room rate
    @block = Hotel::Block.new('2017-08-03', '2017-08-07', 5, 20)
  end

  describe 'initialize' do
    it 'can be instantiated' do
      @block.must_be_kind_of Hotel::Block
    end

    it 'has 9-character @id value' do
      @block.id.must_be_kind_of String
      @block.id.length.must_equal 9
      @block.id[0..4].must_equal 'B0803'
    end
  end

  describe 'includes_dates?' do
    it 'returns true if block includes provided dates' do
      includes_dates = @block.includes_dates?('2017-08-03', '2017-08-07')

      includes_dates.must_equal true
    end

    it 'returns false if block does not include provided dates' do
      includes_dates = @block.includes_dates?('2017-10-14', '2017-10-18')

      includes_dates.must_equal false
    end

    it 'returns true for partial overlap' do
      includes_dates = @block.includes_dates?('2017-08-03', '2017-08-10')

      includes_dates.must_equal false
    end
  end
end
