require_relative 'spec_helper'
require 'pry'

describe Hotel::Hotel do
  describe "a hotel instance can be created" do
    it "can be created" do
      marriott = Hotel::Hotel.new
      marriott.must_be_instance_of Hotel::Hotel
    end

    it "creates 20 rooms upon initializing stored in an Array" do
      marriott = Hotel::Hotel.new
      marriott.rooms.length.must_equal 20
      marriott.rooms.must_be_kind_of Array
    end

    it "creates 20 rooms that are room objects" do
      marriott = Hotel::Hotel.new
      marriott.rooms.each do |room|
        room.must_be_instance_of Hotel::Room
      end
    end

    it "creates 20 hotels that can identify their room numbers" do
      marriott = Hotel::Hotel.new
      i = 1
      marriott.rooms.each do |room|
        room.number.must_equal i
        i += 1
      end

    end
  end #end of initailize Hotel::Hotel tests

  describe "can make and retrieve reservations" do
    before do
      @hilton = Hotel::Hotel.new

      @hilton.make_reservation('Shaunna', Date.new(2018, 5, 7), Date.new(2018, 5, 10))
      @hilton.make_reservation('Shaunna', Date.new(2018, 4, 26), Date.new(2018, 4, 28))
      @hilton.make_reservation('Nathan', Date.new(2019, 12, 4), Date.new(2019, 12, 24))
    end

    it "can make a reservation from inside the hotel class" do
      @hilton.reservations.each do |res|
        res.must_be_instance_of Hotel::Reservation
      end
    end

    it "can retrieve an Array of all the reservations made" do
      @hilton.reservations.length.must_equal 3
      @hilton.reservations.must_be_kind_of Array
    end

    it "returns an Array of length zero if no reservations have been made" do
      davenport = Hotel::Hotel.new
      davenport.reservations.length.must_equal 0
      davenport.reservations.must_be_kind_of Array
    end

    it "can make a reservation with room object by inputing the room number" do
      hotel = Hotel::Hotel.new
      hotel.make_reservation("guest", Date.new(2018, 6, 2), Date.new(2018, 6, 15), 13)
    end

    it "raises a StnadardError when trying to make a reservation for a room that is already reserved" do
      victoria = Hotel::Hotel.new
      victoria.make_reservation("
      guest", Date.new(2018, 6, 2), Date.new(2018, 6, 15), 11)

      proc{victoria.make_reservation("guest", Date.new(2018, 6, 6), Date.new(2018, 6, 20), 11)}.must_raise StandardError
    end

    it "will not raise an exception when trying to make a reservation for a room that starts on the same day another reservation ends" do
      korpela = Hotel::Hotel.new
      korpela.make_reservation("
      guest", Date.new(2018, 6, 2), Date.new(2018, 6, 15), 11)

      korpela.make_reservation("guest", Date.new(2018, 6, 15), Date.new(2018, 6, 20), 11)

      korpela.reservations.length.must_equal 2
    end
  end # end of make and retrieve reservations

  describe "can make a block of rooms" do
    it "can make a block that is passed into an Array" do

      motel8 = Hotel::Hotel.new

      motel8.make_block(Date.new(2018, 5, 5), Date.new(2018, 5, 8), 4)

      motel8.blocks.must_be_kind_of Array

      motel8.blocks.last.must_be_instance_of Hotel::Block
    end

    it "will generate a unique id for the block booking" do

      ############ HOW??? ############


    end

    it "won't assign rooms to the block that aren't available during that date range" do
      holidayinn = Hotel::Hotel.new

      check_in = Date.new(2018, 7, 6)
      check_out = Date.new(2018, 7, 8)

      (1..15).each do |num|
        holidayinn.make_reservation("guest", check_in, check_out, num)
      end

      holidayinn.make_block(check_in, check_out, 5)

      holidayinn.blocks.each do |block|
        block.rooms_in_block.each do |room|
          room.number.between?(1, 15).must_equal false
        end
      end
    end

    it "will only allow a block to reserve a maximum of five rooms" do
      hotel = Hotel::Hotel.new

      check_in = Date.new(2018, 7, 6)
      check_out = Date.new(2018, 7, 8)

      proc{hotel.make_block(check_in, check_out, 6)}.must_raise StandardError

      proc{hotel.make_block(check_in, check_out, 0)}.must_raise StandardError

    end

    it "will make the rooms assigned to the block unavailable for reservation to the general public" do

      parador = Hotel::Hotel.new

      check_in = Date.new(2018, 7, 6)
      check_out = Date.new(2018, 7, 8)

      parador.make_block(check_in, check_out, 4)

      room_numbers = []

      parador.blocks.each do |block|
        block.rooms_in_block.each do |room|
          room_numbers << room.number
        end
      end

      proc{parador.make_reservation("guest", check_in, check_out, room_numbers[0])}.must_raise StandardError

    end
  end


  describe "get_res_by_date" do
    before do
      check_in_day = [2, 2, 6, 4, 8, 6, 12, 23, 17, 2, 3, 5, 22, 29, 10, 10, 1]
      check_out_day =[3, 10, 7, 8, 11, 7, 14, 30, 19, 4, 4, 6, 25, 30, 12, 20, 15]

      i = 0
      @carlisle = Hotel::Hotel.new
      check_in_day.length.times do
        @carlisle.make_reservation("guest", Date.new(2018, 4, check_in_day[i]), Date.new(2018, 4, check_out_day[i]))
        i += 1
      end
    end

    it "returns an Array of Reservations" do
      @carlisle.get_res_by_date(Date.new(2018,4,10)).must_be_kind_of Array
      @carlisle.get_res_by_date(Date.new(2018,4,8)).each do |res|
        res.must_be_kind_of Hotel::Reservation
      end
    end

    it "returns a list of unique Reservations that are occupying rooms that night" do
      reservations_4th = @carlisle.get_res_by_date(Date.new(2018,4,4))
      reservations_10th = @carlisle.get_res_by_date(Date.new(2018,4,10))
      reservations_30th = @carlisle.get_res_by_date(Date.new(2018,4,30))
      reservations_may = @carlisle.get_res_by_date(Date.new(2018,5,10))

      reservations_4th.length.must_equal 3
      reservations_10th.length.must_equal 4
      reservations_may.length.must_equal 0
      reservations_30th.length.must_equal 0
    end

  end # end get_res_by_date



  ########### HOW TO TEST THIS METHOD?? #########
  ## CURRENTLY TESTING FOR LENGTH  ##
  describe "get_available_rooms method" do

    it "returns an Array of Rooms" do
      hotel = Hotel::Hotel.new
      check_in = Date.new(2018, 4, 12)
      check_out = Date.new(2018, 4, 25)

      hotel.get_available_rooms(check_in, check_out).must_be_kind_of Array
    end

    it "returns 17 rooms when there are three room conflicts" do
      hotel = Hotel::Hotel.new
      hotel.make_reservation("guest", Date.new(2018, 9, 10), Date.new(2018, 9, 17))
      hotel.make_reservation("guest", Date.new(2018, 9, 15), Date.new(2018, 9, 23))
      hotel.make_reservation("guest", Date.new(2018, 9, 16), Date.new(2018, 9, 28))
      hotel.make_reservation("guest", Date.new(2018, 4, 16), Date.new(2018, 4, 18))

      hotel.get_available_rooms(Date.new(2018, 9, 14), Date.new(2018, 9, 20)).length.must_equal 17
    end

  end

end











#This is a comment to stop the blinking
