require_relative 'spec_helper'

describe "Room class" do
  before do
    @min = 1
    @max = 20
    (@min..@max).each { |num| Hotel::Room.new(num) }
  end

  after do
    Hotel::Room.clear
  end

  it "can provide a list of all the rooms" do
    Hotel::Room.all.must_be_instance_of Array
    Hotel::Room.all.length.must_equal 20
    Hotel::Room.all.first.room_num.must_equal @min
    Hotel::Room.all.last.room_num.must_equal @max
  end

  it "knows all rooms cost $200 per night" do
    Hotel::Room.all.each { |room| room.rate.must_equal 200 }
  end

  it "can change the cost of a room" do
    Hotel::Room.update_price(1, 400)
    roomarray = Hotel::Room.all.select { |room| room.rate == 400 }
    roomarray.length.must_equal 1
    roomarray[0].room_num.must_equal 1
  end
end
