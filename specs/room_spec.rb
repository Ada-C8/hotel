require_relative 'spec_helper.rb'

describe "Room" do
  before do
    @room = Hotel::Room.new("Room 1", 200)
  end

  describe "Room class" do

    it "is a class of the Hotel module" do
      Hotel::Room.class.must_equal Class
    end

    it "can be instanciated" do
      @room.class.must_equal Hotel::Room
    end
  end

  describe "price attribute" do

    it "Room has a price attribute" do
      @room.must_respond_to :price
    end

    it "returns a float" do
      @room.price.class.must_equal Float
    end

    it "returns the room's price" do
      @room = Hotel::Room.new("Room 1", 300)
      @room.price.must_be :==, 300.00
    end
  end

  describe "name attribute" do

    it "Room has a name attribute" do
      @room.must_respond_to :name
    end

    it "returns a string" do
      @room.name.class.must_equal String
    end

    it "the string returned must be capitalized" do
      @room = Hotel::Room.new("room 1", 200)
      @room.name.must_equal "Room 1"
    end
  end
end
