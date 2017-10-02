# require 'pry'
require_relative 'spec_helper'

describe 'Room class' do
  before do
    @room1 = Hotel::Room.new(1)
  end
  it 'can be instantiated' do
    @room1.must_be_kind_of Hotel::Room
  end

  it 'room number and cost can be accessed' do
    @room1.number.must_equal 1
    @room1.cost.must_equal 200
  end

  it 'can be not reserved but default is true.' do
    @room1.reserved.to_s.must_equal ""
    # I did ^this .to_s because minitest didn't like .must_equal nil......
    room2 = Hotel::Room.new(2, reserved: false)
    room2.reserved.must_equal false
  end

  it 'reserved status can be changed' do
    @room1.reserved = true
    @room1.reserved.must_equal true
  end
end
