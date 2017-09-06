require_relative 'spec_helper'

describe Hotel::Hotel do
  describe "a hotel instance can be created" do
    it "can be created" do
      marriott = Hotel::Hotel.new
      marriott.must_be_instance_of Hotel::Hotel
    end

    it "creates 20 rooms upon initializing" do
      marriott = Hotel::Hotel.new
      marriott.rooms.length.must_equal 20
    end

    it "creates 20 rooms that are room objects" do
      marriott = Hotel::Hotel.new
      marriott.rooms.each do |room|
        room.must_be_instance_of Hotel::Room
      end

    end

  end






end
