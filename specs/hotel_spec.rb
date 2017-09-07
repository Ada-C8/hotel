require_relative 'spec_helper'

describe "Room class" do

it "Can be instantiated" do
  Hotel::Hotel.new(20, 200).must_be_instance_of Hotel::Hotel
end

it "Can create an array of rooms" do
  Hotel::Hotel.new(20, 200).list_of_rooms.length.must_equal 20
end

it "Can call the array of rooms" do
  Hotel::Hotel.new(20,200).list_of_rooms.must_equal [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18, 19, 20]
end

it "Can call on price of rooms" do
  Hotel::Hotel.new(20, 200).price.must_equal 200
end

it "can call on collection of reservations array - will be empty" do
Hotel::Hotel.new(20, 200).reservation_collection.must_be_instance_of Array
end

end #describe
