require_relative 'spec_helper'

describe "Block" do
  before do
    @booking = Hotel::Booking.new
    @checkin_day = Date.new(2017, 9, 5)
    @checkout_day = Date.new(2017, 9, 7)
    @num_of_rooms = 1

    @test_block = @booking.make_block("wedding", @checkin_day, @checkout_day, 3)

    @block = Hotel::Block.new("Wedding", [1, 2, 3], [5,6] )
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

  describe "reserve_room" do
    it "will be able to be called on @block" do
      @block.must_respond_to :reserve_room
    end # it "will be able to be called on @block" do

    it "will make a new instance of Reservation" do
      # in Block
      @block.reserve_room(12, 1).must_be_kind_of Array
      @block.reserve_room(12, 1).each do |res|
        res.must_be_kind_of Hotel::Reservation
      end # .each
    end # it "will make a new instance of Reservation" do

    it "will remove the reserved room from the @block_rooms array" do
      @test_block[0].block_rooms.length.must_equal 3
      @test_block[0].reserve_room("wedding", 2)
      @test_block[0].block_rooms.length.must_equal 1
    end # it "will remove the reserved room from the @block_rooms array" do

    it "will add the right numnber of rooms to the Reservation to the array it returns" do
      @block.reserve_room(12, 3).length.must_equal 1
      @block.reserve_room(12, 3)[0].res_rooms.length.must_equal 3 
    end # it "will add every new Reservation to the array it returns" do
  end # reserve_room
end # describe Block
