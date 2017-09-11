require_relative 'spec_helper'

describe "Blocks class" do
  before do
    @blocks_test = Hotel::Blocks.new("2017-9-13", "2017-9-15")
  end
  describe "Initialize Blocks Class" do
    it "Blocks.new is an instance of Hotel module" do
      @blocks_test.must_be_instance_of Hotel::Blocks
    end
    it "Responds to rooms variable" do
      @blocks_test.must_respond_to :date_range
      @blocks_test.rooms.must_be_kind_of Array
    end
    it "Responds to rooms variable" do
      @blocks_test.must_respond_to :rooms
    end
    it "Responds to rooms variable" do
      @blocks_test.must_respond_to :discounted_rate
    end
  end
end
