require_relative 'spec_helper'

describe "Administration#Block" do

  describe "instantiate a block of rooms" do
    it "create a block of rooms" do
      rooms = []
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)

      block_res = Administration::Block.new(check_in, check_out, rooms)

      block_res.must_respond_to :rooms
      block_res.rooms.must_equal rooms
      block_res.rooms.must_be_kind_of Array

      block_res.must_respond_to :check_in
      block_res.check_in.must_equal check_in
      block_res.check_in.must_be_kind_of Date

      block_res.must_respond_to :check_out
      block_res.check_out.must_equal check_out
      block_res.check_out.must_be_kind_of Date
    end

    it "raise an error if more than 5 rooms in a block" do
      rooms = [ 3, 4, 2, 7, 8, 1 ]
      check_in = Date.new(2017, 9, 1)
      check_out = Date.new(2017, 9, 5)

      proc {
        Administration::Block.new(check_in, check_out, rooms)
      }.must_raise MaxNumRoomsError
    end
  end
end # end of Block
