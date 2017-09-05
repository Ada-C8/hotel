require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/rooms'
require_relative './spec_helper.rb'

describe "Rooms wave 1" do
  describe "initialize rooms" do

  it "can initialize rooms" do
    new_rooms = Hotel::Rooms.new(1)
    new_rooms.must_be_instance_of Hotel::Rooms
    new_rooms.number.must_be_kind_of Integer
  end


end
end
