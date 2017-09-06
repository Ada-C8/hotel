require_relative 'spec_helper'
require 'pry'


describe "Hotel" do
  describe "Room" do

it "has a room number" do
  room_test = Hotel::Room.new
  room_test.room_number.must_be_kind_of Array
  room_test.room_number.must_include 1
  room_test.room_number.must_include 19
end

  end
end
