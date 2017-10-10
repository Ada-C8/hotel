require_relative 'spec_helper.rb'

describe "hotel" do
  before do
    @hotel = Hotel::Hotel.new(3)
  end
  it "has a hotel class" do
    Hotel::Hotel.class.must_be_kind_of Class
  end
  it "is initialized with a parameter" do
    proc {Hotel::Hotel.new}.must_raise ArgumentError
  end
  it "is initialized with a integer parameter" do
    proc {Hotel::Hotel.new("not integer")}.must_raise ArgumentError
  end
  it "has a @list_of_rooms array" do
    @hotel.list_of_rooms.must_be_kind_of Array
  end
  it "has a @list_of_rooms array containing room objects" do
    @hotel.list_of_rooms[0].must_be_kind_of Hotel::Room
  end

end
