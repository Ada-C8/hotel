require_relative 'spec_helper'

describe "My_Hotel::Hotel" do
  describe "initialize" do
    it "creates an instance of Hotel" do
      ritz = My_Hotel::Hotel.new
      ritz.must_be_kind_of My_Hotel::Hotel
      ritz.rooms.must_be_kind_of Hash
      ritz.rooms.length.must_equal 20

    end
  end

  describe "make_reservation" do
    it "can make a reservation" do
      hotel_california = My_Hotel::Hotel.new
      hotel_california.must_be_kind_of My_Hotel::Hotel
      first_night = Date.civil(2017,2,1)
      last_night = Date.civil(2017,2,5)

      holiday = hotel_california.make_reservation(first_night, last_night)
      holiday.must_be_kind_of My_Hotel::Reservation
      #should reject bad dates
    end

    it "calculates the cost" do
      hotel_california = My_Hotel::Hotel.new
      hotel_california.must_be_kind_of My_Hotel::Hotel

      first_night = Date.civil(2017,2,1)
      last_night = Date.civil(2017,2,5)
      holiday = hotel_california.make_reservation(first_night, last_night)
      holiday.cost.must_equal 1000 #nominal case
    end

    it "assigns a room number" do
      hotel_california = My_Hotel::Hotel.new
      hotel_california.must_be_kind_of My_Hotel::Hotel

      first_night = Date.civil(2017,2,1)
      last_night = Date.civil(2017,2,2)
      holiday = hotel_california.make_reservation(first_night, last_night)
      holiday.room_number.must_be_kind_of Integer
      (1..20).must_include holiday.room_number
    end

    it "updates the list_of_reservations" do
      hotel_california = My_Hotel::Hotel.new
      hotel_california.must_be_kind_of My_Hotel::Hotel
      first_night = Date.civil(2017,2,1)
      last_night = Date.civil(2017,2,2)
      holiday = hotel_california.make_reservation(first_night, last_night)
      hotel_california.all_reservations.must_be_kind_of Array
      hotel_california.all_reservations.length.must_equal 1

      first_night = Date.civil(2017,2,1)
      last_night = Date.civil(2017,2,3)
      holiday = hotel_california.make_reservation(first_night, last_night)
      hotel_california.all_reservations.length.must_equal 2
    end
  end
  #
  describe "find_reservations_by_date" do
    it "given a date, it returns an array of reservations on that date" do
      hotel_california= My_Hotel::Hotel.new
      first_night = Date.civil(2017,2,1)
      last_night = Date.civil(2017,2,5)
      hotel_california.make_reservation(first_night, last_night)
      first_night = Date.civil(2017,2,3)
      last_night = Date.civil(2017,5,6)
      hotel_california.make_reservation(first_night,last_night)
      first_night = Date.civil(2017,4,3)
      last_night = Date.civil(2017,4,6)
      hotel_california.make_reservation(first_night, last_night)

      check_date = Date.civil(2017,2,4)
      feb4 = hotel_california.find_reservations_by_date(check_date)

      feb4.must_be_kind_of Array
      feb4.length.must_equal 2

      check_date = Date.civil(2017,2,6)
      feb5 = hotel_california.find_reservations_by_date(check_date)
      feb5.length.must_equal 1
    end

    it "given a date, it returns an empty array if there are no reservations on that date" do
      check_date = Date.civil(2017,5,21)
      first_night = Date.civil(2017,4,3)
      last_night = Date.civil(2017,4,6)
      hotel_california= My_Hotel::Hotel.new
      hotel_california.make_reservation(first_night, last_night)
      may21 = hotel_california.find_reservations_by_date(check_date)
      may21.must_equal []
    end
  end

  describe "find_by_reservation_id" do
    it "given a reservation id, it returns that reservation" do
      hotel_california= My_Hotel::Hotel.new
      first_night = Date.civil(2017,2,1)
      last_night = Date.civil(2017,2,5)
      a = hotel_california.make_reservation(first_night, last_night)
      first_night = Date.civil(2017,2,3)
      last_night = Date.civil(2017,5,6)
      b = hotel_california.make_reservation(first_night,last_night)

      hotel_california.find_by_reservation_id(1).must_equal a
      hotel_california.find_by_reservation_id(2).must_equal b
    end

    it "given a reservation id, it returns nil if that reservation does not exist" do
      hotel_california= My_Hotel::Hotel.new
      hotel_california.find_by_reservation_id(5).must_be_nil
    end
  end

  describe "find unreserved rooms by date" do
    it "returns an hash" do
      hotel_california= My_Hotel::Hotel.new
      first_night = Date.civil(2017,2,1)
      last_night = Date.civil(2017,2,5)
      nights = (first_night .. last_night)
      free_rooms = hotel_california.find_unreserved_rooms(nights)

      free_rooms.must_be_kind_of Hash
      free_rooms.length.must_equal 20
    end

    it "returns a hash of the available rooms" do
      hotel_california= My_Hotel::Hotel.new
      first_night = Date.civil(2017,2,1)
      last_night = Date.civil(2017,2,5)
      nights = (first_night .. last_night)

      index = 1
      20.times do
        hotel_california.make_reservation(first_night,last_night)
        free_rooms = hotel_california.find_unreserved_rooms(nights)
        free_rooms.length.must_equal 20-index
        index += 1
      end
      hotel_california.make_reservation(first_night,last_night)
      free_rooms = hotel_california.find_unreserved_rooms(nights)
      free_rooms.must_equal nil
    end
  end
  #
# I think I should split up find_unreserved rooms and
#reservation so that first the user can see if there are
#any unreserved rooms for that night.  If so, they can assign one of them by passing it as an argument into make_reservation
  #
  #
  # end
end







# describe "display_rooms"
# it "must puts out a list of all the rooms" do
#   #TODO: Test
# end
#
#
# describe "display_reservations" do
#   it "must put out a list of all the reservations" do
#     #TODO: Test
#   end
# end
#
#
# describe "rooms_available_date" do
#   it "must return a list of availble rooms" do
#     #TODO: Test - List == array?
#     #- List == correct list
#     # rejects bad dates
#   end
# end
#
# describe "rooms_available_block" do
#   it "must return a list of availble rooms in a block" do
#     #TODO: Test - List == array?
#     #- List == correct list
#     # rejects bad dates
#     #rejects bad block ids
#   end
# end
#
# describe "make block" do
#   it "must allow the admin to assign a block_id to rooms" do
#     #TODO: test
#   end
# end
