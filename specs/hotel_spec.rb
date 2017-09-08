require_relative 'spec_helper'

describe "Administration#Hotel" do
  describe "instantiate hotel" do
    it "return all 20 rooms" do
      all_rooms = (1..20).to_a
      hotel = Administration::Hotel.new(all_rooms)
      hotel.all_rooms.length.must_equal 20
      hotel.all_rooms.must_be_kind_of Array
    end

    it "return a given room" do
      all_rooms = (1..20).to_a
      hotel = Administration::Hotel.new(all_rooms)
      hotel.all_rooms[0].must_equal 1
      hotel.all_rooms.first.must_equal 1
      hotel.all_rooms.last.must_equal 20
    end

    
  end


end
