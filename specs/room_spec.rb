require_relative 'spec_helper.rb'

describe "hotel" do
  before do
    @room = Hotel::Room.new
  end
  it "has a hotel class" do
    Hotel::Room.class.must_be_kind_of Class
  end
  it "return @price == 200 is no parameter is passed" do
    @room.price.must_equal 200
  end
end
