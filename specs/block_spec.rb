require_relative 'spec_helper'

require 'date'

describe "Block" do
  let(:block) { Hotel::Block.new({ name: "blanco", checkin: "10-01-2017", checkout: "10-04-2017", room: [1, 4, 7, 8], discount: "10" }) }

  it "is-a type of Reservation" do
    block.must_be_kind_of Hotel::Reservation
    block.must_be_instance_of Hotel::Block
  end

  it "can read its attributes" do
    block.checkin.must_equal Date.new(2017, 10, 1)
    block.must_respond_to :room
    block.room.must_be_instance_of Array
    block.must_respond_to :checkout
    block.checkout.must_equal Date.new(2017, 10, 4)
  end

  it "uses discount to calculate cost" do
    block.cost.must_equal 540
  end
end
