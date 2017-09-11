require_relative 'spec_helper'

describe "Blocks class" do
  before do
    @blocks_test = Hotel::Blocks.new#("2017-9-13", "2017-9-15")
    @hotel_test = Hotel::HotelClass.new
  end
  describe "Initialize Blocks Class" do
    it "Blocks.new is an instance of Hotel module" do
      @blocks_test.must_be_instance_of Hotel::Blocks
    end
    it "Responds to date_range variable" do
      @blocks_test.must_respond_to :date_range
      @blocks_test.block_rooms.must_be_kind_of Array
    end
    it "Responds to block_rooms variable" do
      @blocks_test.must_respond_to :block_rooms
    end
    it "Responds to discount variable" do
      @blocks_test.must_respond_to :discount
    end
    it "Responds to hotel variable" do
      @blocks_test.must_respond_to :hotel
    end
  end
  describe "Create Block method" do
    it "Returns an array" do
      hotel_test2 = Hotel::HotelClass.new
      hotel_test2.reserve_room(2,"2017-9-15", "2017-9-18")
      hotel_test2.reserve_room(3,"2017-9-15", "2017-9-18")
      hotel_test2.reserve_room(1,"2017-9-15", "2017-9-18")
      ap hotel_test2.view_available_rooms("2017-9-15", "2017-9-18")
      @blocks_test.create_block(2,"2017-9-15", "2017-9-17").must_be_kind_of Array
      # @blocks_test.block_rooms.length.must_equal 5
    end
    it "Contains 5 rooms" do
      @blocks_test.create_block([4,5,6,7,8],"2017-9-15", "2017-9-17")
      @blocks_test.block_rooms.length.must_equal 5
    end
  end
end # end of Blocks class describe
