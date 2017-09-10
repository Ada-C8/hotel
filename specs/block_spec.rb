require_relative 'spec_helper'


describe 'Block class' do
  before do
    @checkin = Date.new(2018,03,05)
    @checkout = Date.new(2018,03,10)
    @rooms_set = [17, 18, 19, 10]
    @price = 150
    @blocknew = Hotel::Block.new(@checkin, @checkout, @rooms_set, @price)
  end

  describe 'initialize' do
    it 'can be initialize' do
      @blocknew.must_be_instance_of Hotel::Block
    end
  end#initialize

  describe 'totalcost' do
    it 'get the right price for the date range' do
      @blocknew.totalcost_oneroom.must_equal 750
    end
  end

  describe 'reserve' do
    it 'change the rooms_set when you make a reservation' do
      @blocknew.reserve.must_equal [18, 19, 10]
      @blocknew.reserve.must_equal [19, 10]
    end

    it 'raises argument error if there is not more rooms in block' do
      4.times do
        @blocknew.reserve
      end
      proc{@blocknew.reserve}.must_raise ArgumentError
    end
  end
end
