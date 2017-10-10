require_relative 'spec_helper.rb'


describe "Room" do
  before do
    @room = Hotel::Room.new
    @room2 = Hotel::Room.new(400)
  end

  describe "Room class" do
    it "has a room class" do
      Hotel::Room.class.must_be_kind_of Class
    end
  end

  describe "@price" do

    it "return @price == 200 if no parameter is passed" do
      @room.price.must_equal 200
    end

    it "returns the price given" do
      @room2.price.must_equal 400
    end
  end

  describe "@bookings" do
    it "has a @booking variable" do
      @room.must_respond_to :bookings
    end
  end

end
