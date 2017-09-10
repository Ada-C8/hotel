require_relative 'spec_helper'

describe 'Block' do
  before do
    # - To create a block you need a date range, collection of rooms and a discounted room rate
    @hotel = Hotel::Hotel.new(20)
    @block = @hotel.make_block('2017-08-03', '2017-08-07', 5, 20)
  end

  describe 'initialize' do
    it 'can be instantiated' do
      @block.must_be_kind_of Hotel::Block
    end

    it 'has 9-character @id value' do
      @block.id.must_be_kind_of String
      @block.id.length.must_equal 9r
      @block.id[0..4].must_equal 'B0803'
    end

    it 'has array of Room objects' do
      @block.rooms.must_be_kind_of Array
      @block.rooms.each do |room|
        room.must_be_kind_of Hotel::Room
      end
    end

    it 'raises ArgumentError if passed invalid dates' do
      proc {
        Hotel::Block.new('sea','HAWKS', 5, 20)
      }.must_raise ArgumentError
    end

    it 'raises DatesError if dates are out of order' do
      proc {
        Hotel::Block.new('2017-08-08', '2017-08-03', 5, 20)
      }.must_raise DatesError
    end

    it 'raises DatesError if dates do not span at least 1 night' do
      proc {
        Hotel::Block.new('2017-08-06', '2017-08-06', 5, 20)
      }.must_raise DatesError
    end

    it 'has 0 >= n >= 1 discount_rate value' do
      @block.discount_rate.must_equal 0.8
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

    it 'raises ArgumentError if passed invalid dates' do
      proc {
        @block.includes_dates?('sea','HAWKS')
      }.must_raise ArgumentError
    end

    it 'raises DatesError if dates are out of order' do
      proc {
        @block.includes_dates?('2017-08-08', '2017-08-03')
      }.must_raise DatesError
    end

    it 'raises DatesError if dates do not span at least 1 night' do
      proc {
        @block.includes_dates?('2017-08-06', '2017-08-06')
      }.must_raise DatesError
    end
  end

  xdescribe 'get_discount_rate' do
    it 'converts percentage number into equivalent Float' do
      @block.get_discount_rate(80).must_equal 0.2
      @block.get_discount_rate(75).must_equal 0.25
      @block.get_discount_rate(10).must_equal 0.9
      @block.get_discount_rate(12.5).must_equal 0.875r
    end
  end
end
