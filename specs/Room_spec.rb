require_relative 'spec_helper'

describe "Hotel::Room class" do
  describe "initialize" do
    it "requires one argument, number" do
      proc {Hotel::Room.new}.must_raise ArgumentError

      new_room = Hotel::Room.new(1)
      new_room.must_be_instance_of Hotel::Room
    end

    it "creates a new Room object with the correct id, and initialized with the correct default values for status and nightly_rate" do
      new_room = Hotel::Room.new(1)

      new_room.id.must_equal 1
      new_room.status.must_equal :available
      new_room.nightly_rate.must_equal 200
    end

    it "can take an optional argument nightly_rate if we want to give it a different nightly_rate" do
      vip_room = Hotel::Room.new(100, 350)

      vip_room.id.must_equal 100
      vip_room.nightly_rate.must_equal 350
    end

  end #end initialize


end #end Hotel::Room class tests
