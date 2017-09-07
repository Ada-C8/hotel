require_relative 'spec_helper'

describe "BookingProgram" do
  describe "Initialize" do
    it "initializes with 20 rooms, numbered 1 through 20 and I can can access the list of all rooms " do
      new_hotel = Hotel::BookingProgram.new

      new_hotel.all_rooms.must_be_instance_of Array
      new_hotel.all_rooms.each do |room|
        room.must_be_instance_of Hotel::Room
      end


    end

  end

  describe "find_res_by_date" do
    it "Returns an array of Reservation objects" do
      new_hotel =  Hotel::BookingProgram.new

      new_hotel.make_reservation(1, "2018-03-14", "2018-04-16", 3)

      new_hotel.make_reservation(2, "2018-03-14", "2018-04-16", 5)

      new_hotel.make_reservation(3, "2018-02-02", "2018-02-08", 18)

      new_hotel.make_reservation(5, "2018-12-08", "2018-12-10", 7)

      new_hotel.make_reservation(4, "2018-03-21", "2018-03-22", 15)


      new_hotel.find_res_by_date("2018-03-21").must_be_instance_of Array

      new_hotel.find_res_by_date("2018-03-21").count.must_equal 3

      p new_hotel.find_res_by_date("2018-03-21")

    end
  end #end find_res_by_date


  describe "available_rooms" do
    before do
      @new_hotel = Hotel::BookingProgram.new
      @check_in = "June 1, 2018"
      @check_out = "June 30, 2018"
      @june_rooms = @new_hotel.available_rooms(@check_in, @check_out)
    end

    it "returns an array of available rooms" do

      @june_rooms.must_be_instance_of Array
      @june_rooms.count.must_equal 20
      @june_rooms.each do |room|
        room.must_be_instance_of Hotel::Room
      end
    end

    it "updates correctly when all rooms are reserved" do
      @new_hotel.all_rooms.each do |room|
        guest_idx = 1
        res_idx = 10
        room.reserve_room(@check_in, @check_out, res_idx, guest_idx)

        guest_idx +=1
        res_idx +=1
      end

      updated_june_rooms= @new_hotel.available_rooms(@check_in, @check_out)

      updated_june_rooms.count.must_equal 0
      updated_june_rooms.must_be_instance_of Array

    end

    it "shows the correct number when all but one room are reserved" do
      @new_hotel.all_rooms[1..-1].each do |room|
        guest_idx = 1
        res_idx = 10
        room.reserve_room(@check_in, @check_out, res_idx, guest_idx)

        guest_idx +=1
        res_idx +=1
      end

      binding.pry

      updated_june_rooms= @new_hotel.available_rooms(@check_in, @check_out)

      updated_june_rooms.count.must_equal 1
      updated_june_rooms.must_be_instance_of Array
    end

  end #end available_rooms

end
