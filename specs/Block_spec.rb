require_relative 'spec_helper'

module Hotel
  class Room
    def self.clear
      @@rooms = []
    end
  end

  class Reservation
    def self.clear
      @@reservations = []
    end
  end
end

describe "Block class" do

  before do
    @min = 1
    @max = 20
    (@min..@max).each { |num| Hotel::Room.new(num) }
  end

  after do
    Hotel::Room.clear
    Hotel::Reservation.clear
  end

  it "can create a block with a date range, collection of rooms, and a discounted room rate" do
    proc{Hotel::Block.new}.must_raise Exception
    # the discount is an optional argument, default set to 0.10
    Hotel::Block.new(Date.today, Date.today + 1, 12).must_be_instance_of Hotel::Block
    Hotel::Block.new(Date.today, Date.today + 1, 12, 0.15).must_be_instance_of Hotel::Block
    x = Hotel::Block.new(Date.today, Date.today + 1, 12, 0.15)
    x.start_date.must_be_instance_of Date
    x.end_date.must_be_instance_of Date
    x.discount.must_be_instance_of Float
    x.rooms.must_be_instance_of Array
    x.rooms.each { |room_num| (@min..@max).to_a.include?(room_num).must_equal true }
  end

  xit "only makes blocks with rooms available during the specified date range" do

  end

  xit "prevents blocked rooms from being reserved by the general public" do

  end

  xit "prevents a room from being in two blocks at the same time" do

  end

  xit "allows a user to check if a given block has rooms available" do

  end

  xit "allows a user to reserve a room from within a block of rooms" do

  end

end
