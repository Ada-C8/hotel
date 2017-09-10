require_relative 'spec_helper'


describe 'Block class' do
  describe 'initialize' do
    it 'can be initialize' do
      checkin = Date.new(2018,03,05)
      checkout = Date.new(2018,03,10)
      rooms_set = [17, 18, 19, 10]
      price = 150
      blocknew = Hotel::Block.new(checkin, checkout, rooms_set, price)
      blocknew.must_be_instance_of Hotel::Block
    end
  end
end
