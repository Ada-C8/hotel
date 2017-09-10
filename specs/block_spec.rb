require_relative 'spec_helper'
require 'date'

describe "Block Class" do


  it "Can instantiate a block" do
    date = Date.today
    new_block = HotelManagment::Block.new(date + 1, date + 3, 5)
    new_block.must_be_instance_of HotelManagment::Block

  end

  it "amount_of_rooms should be an integer" do
    date = Date.today

    new_block = HotelManagment::Block.new(date + 1, date + 3, 5)
    new_block.amount_of_rooms.must_be_instance_of Integer
  end

  it "Amount_of_rooms should be equal to 5" do
    date = Date.today

    new_block = HotelManagment::Block.new(date + 1, date + 3,5)
    new_block.amount_of_rooms.must_equal 5
  end

  it "RATE should be equal to 100" do
    HotelManagment::Block::BLOCKRATE.must_equal 100
  end

  it "Rate should be an instance of a Constant" do
    HotelManagment::Block::BLOCKRATE.must_equal 100
  end

end
