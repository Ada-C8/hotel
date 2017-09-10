

require_relative './spec_helper.rb'

describe "Hotel" do
  describe "initialize hotel" do

  it "can initialize hotel" do
    new_hotel = Hotels::Hotel.new
    new_hotel.must_be_instance_of Hotels::Hotel
    new_hotel.reservations.must_be_kind_of Array
    new_hotel.rooms.must_be_instance_of Array
  end

  describe "check_dates" do
    it "can check if date is in the future" do
      new_hotel = Hotels::Hotel.new
      dates = new_hotel.check_dates([2020, 9, 10], [2020, 9, 12])
      dates.must_be_instance_of Array
      dates[0].must_be_instance_of Date

      test_date = Date.new(2020, 9, 10)
      dates[0].must_equal test_date
    end
    it "throws an error if date is in the past" do
      new_hotel = Hotels::Hotel.new
      proc {new_hotel.check_dates([1970, 9, 10], [2020, 9, 12])}.must_raise ArgumentError
    end

    it "throws error if end date is before start date" do
      new_hotel = Hotels::Hotel.new
      proc {new_hotel.check_dates([2020, 9, 10], [2000, 9, 12])}.must_raise ArgumentError
    end
    it "throws an error if dates are not in correct format" do
      new_hotel = Hotels::Hotel.new
      proc {new_hotel.check_dates(["a",10,2020], ["b",3,2000])}.must_raise ArgumentError
      proc {new_hotel.check_dates([1,30,2020], [100,3,2000])}.must_raise ArgumentError
    end
    it "thows an error if start and end date are the same" do
      new_hotel = Hotels::Hotel.new
      proc {new_hotel.check_dates([2020, 9, 10], [2020, 9, 10])}.must_raise ArgumentError
    end
  end

  describe "date_range" do
    it "can create a date range" do
      new_hotel = Hotels::Hotel.new
      dates = new_hotel.check_dates([2020, 9, 10], [2020, 9, 12])
      date_range = new_hotel.date_range(dates)

      date_range.must_be_instance_of Array
      date_range.length.must_equal 2

      test_date = Date.new(2020, 9, 11)
      date_range[1].must_equal test_date
    end
  end

  describe "list_booked_rooms" do
    it "can list booked rooms" do
      new_hotel = Hotels::Hotel.new
      dates = new_hotel.check_dates([2020, 9, 10], [2020, 9, 12])
      date_range = new_hotel.date_range(dates)
      list_booked = new_hotel.list_booked_rooms(date_range)
      unbooked = new_hotel.list_unbooked_rooms(list_booked)
      find_room = new_hotel.find_room(unbooked)
      new_res = new_hotel.make_reservation(find_room, date_range)
      list_booked = new_hotel.list_booked_rooms(date_range)

      list_booked[0].must_equal find_room
      list_booked.length.must_equal 2
    end
  end

  describe "list_unbooked_rooms" do
    it "can list booked rooms" do
      new_hotel = Hotels::Hotel.new
      dates = new_hotel.check_dates([2020, 9, 10], [2020, 9, 12])
      date_range = new_hotel.date_range(dates)
      list_booked = new_hotel.list_booked_rooms(date_range)
      unbooked = new_hotel.list_unbooked_rooms(list_booked)
      find_room = new_hotel.find_room(unbooked)
      new_res = new_hotel.make_reservation(find_room, date_range)
      list_booked = new_hotel.list_booked_rooms(date_range)
      unbooked = new_hotel.list_unbooked_rooms(list_booked)
      check_lists = unbooked.include? list_booked[0]


      unbooked[0].must_be_instance_of Hotels::Rooms
      unbooked.length.must_equal 19
      check_lists.must_equal false
    end
  end

  describe "find_room" do
    it "can find a room" do
      new_hotel = Hotels::Hotel.new
      dates = new_hotel.check_dates([2020, 9, 10], [2020, 9, 12])
      date_range = new_hotel.date_range(dates)
      list_booked = new_hotel.list_booked_rooms(date_range)
      unbooked = new_hotel.list_unbooked_rooms(list_booked)
      find_room = new_hotel.find_room(unbooked)
      new_res = new_hotel.make_reservation(find_room, date_range)
      dates2 = new_hotel.check_dates([2020, 9, 10], [2020, 9, 12])
      date_range2 = new_hotel.date_range(dates2)
      list_booked2 = new_hotel.list_booked_rooms(date_range2)
      unbooked2 = new_hotel.list_unbooked_rooms(list_booked2)
      find_room2 = new_hotel.find_room(unbooked2)

      find_room2.must_be_instance_of Hotels::Rooms

    end
    it "won't book when hotel is full" do
      new_hotel = Hotels::Hotel.new

      proc {new_hotel.find_room([])}.must_raise ArgumentError
    end
  end



  describe "make_reservation" do
    it "can make a reservation" do
      new_hotel = Hotels::Hotel.new
      dates = new_hotel.check_dates([2020, 9, 10], [2020, 9, 12])
      date_range = new_hotel.date_range(dates)
      find_room = Hotels::Rooms.new(1)
      new_res = new_hotel.make_reservation(find_room, date_range)

      new_res[0].must_be_instance_of Hotels::Reservations
    end
  end




end
end
