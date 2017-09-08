require_relative 'spec_helper.rb'
require "awesome_print"

describe "Hotel_System::Hotel" do
  before do
    @hotel = Hotel_System::Hotel.new(20)
  end

  it "can initialize a new hotel" do
    @hotel.must_be_instance_of Hotel_System::Hotel
  end

  it "adds the correct number of rooms to a new hotel" do
    @hotel.all_rooms.length.must_equal 20
  end

  it "hotel is an array of room objects" do
    @hotel.all_rooms.each do |room|
      room.must_be_instance_of Hotel_System::Room
    end
  end

  it "can access room number from room object" do
    @hotel.return_room_object_by_num(1).room_number.must_equal 1
    @hotel.return_room_object_by_num(20).room_number.must_equal 20
  end

  it "list_of_rooms returns list of all hotel rooms" do
    @hotel.list_of_rooms.must_be_instance_of Array
    @hotel.list_of_rooms.length.must_equal 20
    @hotel.list_of_rooms[0].must_equal 1
    @hotel.list_of_rooms[19].must_equal 20
  end

  it "can access room price for a given room" do
    @hotel.return_room_object_by_num(1).price.must_equal 200
    @hotel.return_room_object_by_num(20).price.must_equal 200
  end

end


describe "all_reservations" do
  it "can store a list of reservations" do
    @hotel2 = Hotel_System::Hotel.new(20)
    # @room = @hotel2.return_room_object_by_num(1)
    res = @hotel2.make_reservation(1, "2018-1-1", "2018-1-5")
    res2 = @hotel2.make_reservation(1, "2017-12-25", "2018-1-4")
    @hotel2.all_reservations.length.must_equal 2
    @hotel2.all_reservations.must_be_instance_of Array
  end
end

describe "reservations by date" do
  it "reservations by date can return list of all reservations on given date" do
    @hotel2 = Hotel_System::Hotel.new(20)
    res = @hotel2.make_reservation(1, "2018-1-1", "2018-1-5")
    res2 = @hotel2.make_reservation(1, "2017-12-25", "2018-1-4")
    res3 = @hotel2.make_reservation(3, "2017-10-10", "2017-10-15")
    list = @hotel2.reservations_by_date("2017-12-26")
    list.length.must_equal 1
    list2 = @hotel2.reservations_by_date("2018-1-1")
    list2.length.must_equal 2
  end
end

describe "available rooms list" do
  # it "can return a list of room numbers of unreserved rooms" do
  #   @hotel2 = Hotel_System::Hotel.new(20)
  # res = @hotel2.make_reservation(1, "2018-1-1", "2018-1-5")
  # res2 = @hotel2.make_reservation(2, "2017-12-25", "2018-1-4")
  #   list = @hotel2.available_rooms("2018-1-1")
  #   list.must_equal Array(2..20)
  # end

  it "available_room_hash produces a hash" do
    @hotel = Hotel_System::Hotel.new(20)
    @hotel.available_room_hash.must_be_instance_of Hash
    @hotel.available_room_hash.length.must_equal 20
  end

  it "available_room_hash returns correct value" do
    @hotel = Hotel_System::Hotel.new(20)
    @hotel.available_room_hash[1].must_equal :available
    @hotel.available_room_hash[20].must_equal :available
  end

  it "availability_room_hash_by_date returns a hash" do
    @hotel = Hotel_System::Hotel.new(20)
    hash = @hotel.availability_room_hash_by_date("2017-9-30")
    hash.must_be_instance_of Hash
  end

  it "availability_room_hash_by_date returns availabe for all rooms if no reservations" do
    @hotel = Hotel_System::Hotel.new(20)
    hash = @hotel.availability_room_hash_by_date("2017-9-30")
    hash.each do |k, v|
      v.must_equal :available
    end
  end

  it "availability_room_hash_by_date returns reserved if that room is reserved on that date" do
    @hotel = Hotel_System::Hotel.new(20)
    res = @hotel.make_reservation(1, "2018-1-1", "2018-1-5")
    hash = @hotel.availability_room_hash_by_date("2018-1-1")
    hash[1].must_equal :reserved
    hash2 = @hotel.availability_room_hash_by_date("2018-1-3")
    hash2[1].must_equal :reserved
  end

  it "available_rooms_by_date returns array" do
    @hotel = Hotel_System::Hotel.new(20)
    res = @hotel.make_reservation(1, "2018-1-1", "2018-1-5")
    list = @hotel.available_rooms_by_date("2018-1-1")
    list.must_be_instance_of Array
    list.length.must_equal 19
  end

  it "available_rooms_by_date returns list of all rooms available" do
    @hotel = Hotel_System::Hotel.new(20)
    res = @hotel.make_reservation(1, "2018-1-1", "2018-1-5")
    res2 = @hotel.make_reservation(2, "2017-12-25", "2018-1-4")
    list = @hotel.available_rooms_by_date("2018-1-1")
    list.must_be_instance_of Array
    list.length.must_equal 18
  end
end

describe "avail_rooms_by_daterange" do
  it "avail_rooms_by_daterange returns array of arrays" do
    @hotel = Hotel_System::Hotel.new(20)
    res = @hotel.make_reservation(1, "2018-1-1", "2018-1-5")
    res2 = @hotel.make_reservation(2, "2017-12-25", "2018-1-4")
    res3 = @hotel.make_reservation(19, "2018-1-3", "2018-1-31")
    date_range = res.res_date_range_generator
    master_list = @hotel.avail_rooms_by_daterange(date_range)
    master_list.must_be_instance_of Array
    master_list.wont_include 1
    master_list.wont_include 2
    master_list.wont_include 19
    master_list.must_include 20
  end
end

describe "avail_checker" do
  it "avail_checker makes reservation if room not already reserved" do
    @hotel = Hotel_System::Hotel.new(20)
    res = @hotel.avail_checker(1, "2018-1-1", "2018-1-5")
    res2 = @hotel.avail_checker(2, "2017-12-25", "2018-1-4")
    @hotel.availability_room_hash_by_date("2018-1-2")[1].must_equal :reserved
    @hotel.availability_room_hash_by_date("2018-1-2")[2].must_equal :reserved
    @hotel.availability_room_hash_by_date("2018-1-2")[20].must_equal :available
    @hotel.available_rooms_by_date("2017-12-26").wont_include 2
  end

  it "avail_checker returns argument error if room already reserved" do
    @hotel = Hotel_System::Hotel.new(20)
    res = @hotel.avail_checker(1, "2018-1-1", "2018-1-5")
    res2 = @hotel.avail_checker(2, "2017-12-25", "2018-1-4")
    proc {@hotel.avail_checker(1, "2018-1-1", "2018-1-3")}.must_raise ArgumentError
    proc {@hotel.avail_checker(2, "2018-1-3", "2018-1-4")}.must_raise ArgumentError
    begin @hotel.avail_checker(2, "2018-1-3", "2018-1-4")
    rescue ArgumentError => e
      e.message.must_equal("Room not available")
    end
  end

end
