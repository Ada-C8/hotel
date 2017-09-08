require_relative 'spec_helper'

describe "Block Class" do
  before do
    id = 1
    rooms = [Hotel::Room.new(3),Hotel::Room.new(2),Hotel::Room.new(1)]
    date_range = Hotel::DateRange.new(Date.new(2017,3,9),Date.new(2017,3,13))
    @wedding = Hotel::Block.new(id, rooms, date_range, "Royal Wedding",175)
  end
  it "can be instantiated" do
    @wedding.must_be_kind_of Hotel::Block
    # binding.pry
  end
  it "must respond to all intance variables" do
    @wedding.must_respond_to :id
    @wedding.must_respond_to :total_cost
    @wedding.must_respond_to :rooms
    @wedding.must_respond_to :date_range
    @wedding.must_respond_to :nights
    @wedding.must_respond_to :block_info
  end
end
