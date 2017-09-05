require_relative 'spec_helper'

module Hotel
  class Room
    def self.clear
      @@rooms = []
    end
  end
end

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
    Hotel::Room.all.first[:room_num].must_equal @min
    Hotel::Room.all.last[:room_num].must_equal @max
  end

  it "knows all rooms cost $200 per night" do
    Hotel::Room.all.each { |room| room[:rate].must_equal 200 }
  end

  xit "can reserve a room for a given date range" do

  end

  xit "can access the list of reservations for a specific date" do

  end

  xit "can get the total cost for a given reservation" do

  end
end
