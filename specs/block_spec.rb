require_relative 'spec_helper'

describe "Block" do
  before do
    @block = Hotel::Block.new("Wedding", [1], [5,6] )
  end # do


  describe "initialize" do
    it "will create an instance of the Block class" do
      @block.must_be_kind_of Hotel::Block
    end # it "will create an instance of the Block class" do
  end # describe "initialize" do
end # describe Block
