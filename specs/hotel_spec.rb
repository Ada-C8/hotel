require_relative './spec_helper'
require_relative '../lib/hotel'

describe "#HOTEL" do
  before do
    @my_hotel = Hotel.new
  end

    it "Hotel Can initialize with 20 rooms" do
      @my_hotel.must_be_instance_of Hotel
      @my_hotel.rooms.length.must_equal 20
    end

    it "Can return a list of all rooms in the hotel" do
      @my_hotel.rooms.must_be_instance_of Array
      @my_hotel.rooms.first.must_be_instance_of Room
    end


    #CLI feature
    # it "#show_all_rooms returns a display of all of the available rooms" do
    #   @my_hotel.show_all_rooms.must_be_instance_of Array
    #   @my_hotel.show_all_rooms.length.must_equal 20
    #   @my_hotel.show_all_rooms.first.must_equal "{number: 1, rate: 200}"
    # end
  end
#
#   xdescribe "check_status" do
#     it "Returns the status of a room for the given date range" do
#       #
#     end
#   end
# end
