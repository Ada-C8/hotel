require_relative 'spec_helper'

describe "Building" do
  describe "initialize" do
    it "Creates an array of 20 rooms with room numbers" do
      ada_inn = Hotel::Building.new

      ada_inn.rooms.must_be_kind_of Array
      ada_inn.rooms.length.must_equal 20
      ada_inn.rooms[0].must_be_instance_of Hotel::Room
      ada_inn.rooms[0].number.must_equal 1
      ada_inn.rooms[-1].number.must_equal 20
      ada_inn.rooms[300].must_be_nil
    end

  end
end
