require_relative 'spec_helper'

describe "Rooms wave 1" do
  before do
    @rooms = Hotel::Hotel_Rooms.new(1)
  end

  it "can initialize rooms" do
    @rooms.must_be_instance_of Hotel::Hotel_Rooms
    @rooms.number.must_be_kind_of Integer
  end


end
