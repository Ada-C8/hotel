require_relative 'spec_helper'

describe 'DateRange' do

  describe "initialize" do
    it "creates a new instance of DateRange" do
      check_in = Date.new(2017, 03, 11)
      check_out = Date.new(2017, 04, 11)
      DateRange.new(check_in, check_out ).must_be_instance_of DateRange
    end

    # it "requires check_in and check_out date for new instance" do
    #   DateRange.new.must_be_instance_of DateRange
    # end
  end

  #   it "initialize with all rooms in hotel as array" do
  #     Hotel.new.rooms.must_be_kind_of Array
  #   end
  #
  #   it "room array elements range from 1 to 20" do
  #     small_hotel = Hotel.new
  #     small_hotel.rooms[0].must_equal 1
  #     small_hotel.rooms[19].must_equal 20
  #   end
  #
  #   it "can access list of all rooms in hotel" do
  #     hotel_list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
  #     Hotel.new.rooms.must_equal hotel_list
  #
  #   end
  # end

end
