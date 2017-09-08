require_relative 'spec_helper'

describe "Block" do
  before do
    @block = Hotel::Block.new("Wedding", [1], [5,6] )
  end # do

  describe "initialize" do
    it "will create an instance of the Block class" do
      @block.must_be_kind_of Hotel::Block
    end # it "will create an instance of the Block class" do

    it "will respond to block_id" do
      @block.must_respond_to :block_id
    end # it "will respond to block_id" do

    it "must respond to block_rooms" do
      @block.must_respond_to :block_rooms
    end # it "must respond to block_rooms" do

    it "must respond to date_range" do
      @block.must_respond_to :date_range
    end # it "must respond to date_range" do
  end # describe "initialize" do
end # describe Block
