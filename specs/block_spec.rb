require_relative 'spec_helper'
require 'pry'


describe "Hotel" do
  describe "Block" do

    before do
      collection_of_rooms = [
        Hotel::Room.new(2)
      ]

      @room1 = Hotel::Block.new(Date.new(2017,8,5), Date.new(2017,8,8), collection_of_rooms, "wedding")
    end


    it "booking will include dates and id number" do
      @room1.must_respond_to :dates
      @room1.must_respond_to :id
    end

    it "will calculate total cost" do
      @room1.block_total_cost.must_equal 480 #600-120
    end



  end
end
