require_relative 'spec_helper'

describe "Block class" do
  before do
    @block_test = Hotel::Block.new#("2017-11-13", "2017-11-15")
    @hotel_test = Hotel::Hotel.new
  end
  describe "Initialize Block Class" do
    it "Block.new is an instance of Hotel module" do
      @block_test.must_be_instance_of Hotel::Block
    end
    it "Responds to date_range variable" do
      @block_test.must_respond_to :date_range
      @block_test.block_rooms.must_be_kind_of Array
    end
    it "Responds to block_rooms variable" do
      @block_test.must_respond_to :block_rooms
    end
    it "Responds to discount variable" do
      @block_test.must_respond_to :discount
    end
    it "Responds to hotel variable" do
      @block_test.must_respond_to :hotel
    end
  end
  describe "Create Block method" do
    it "Returns an array" do
      hotel_test2 = Hotel::Hotel.new
      hotel_test2.reserve_room(2,"2017-11-15", "2017-11-18")
      hotel_test2.reserve_room(3,"2017-11-15", "2017-11-18")
      hotel_test2.reserve_room(1,"2017-11-15", "2017-11-18")
      ap hotel_test2.view_available_rooms("2017-11-15", "2017-11-18")
      @block_test.create_block(2,"2017-11-15", "2017-11-17").must_be_kind_of Array
      # @block_test.block_rooms.length.must_equal 5
    end
    it "Contains 5 rooms" do
      skip
      @block_test.create_block([4,5,6,7,8],"2017-11-15", "2017-11-17")
      @block_test.block_rooms.length.must_equal 5
    end
  end
end # end of Block class describe
