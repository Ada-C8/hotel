require_relative "spec_helper"

describe "reservation class" do
  describe "initialize" do
    it "exists" do
    Hotel::Reservation.new.must_be_instance_of Hotel::Reservation
    end
  end
  describe "date range" do
    it "creates an array of dates" do
      make_date = Hotel::Reservation.new
      make_date.date_range("12-5-2017","12-10-2017").must_be_instance_of Array
      make_date.date_range("12-5-2017","12-10-2017").length.must_equal 6
    end
    it "takes in a starting and ending date" do
      make_date = Hotel::Reservation.new
      dates = make_date.date_range("12-5-2017","12-10-2017")
      dates.must_be_instance_of Array
      dates[0].must_be_kind_of String
    end
  end

  describe "available room" do
    it "provides an instance of the first available room" do
      pikachu_requests = Hotel::Reservation.new
      pikachu_requests.available_room.must_be_instance_of Hotel::Room
      pikachu_requests.available_room.num.must_equal 1
    end
  end

  describe "reserve room" do
    it "creates a reservation" do
      ash_says = Hotel::Reservation.new
      d = ash_says.date_range("10-1-2017","10-5-2017")
      num = ash_says.available_room
      ash_says.reserve_room(d, num).must_be_instance_of Array
    end
    it "adds to reservations array" do
      oddish_asks = Hotel::Reservation.new
      oddish_asks.reservations.length.must_equal 0
      d = oddish_asks.date_range("10-1-2017","10-5-2017")
      num = oddish_asks.available_room
      oddish_asks.reserve_room(d, num)
      oddish_asks.reservations.length.must_equal 1
    end
    it "works w/ reserve room to add reservations to different room numbers" do
      pokemon_hotel = Hotel::Reservation.new

      b_dates = pokemon_hotel.date_range("11-5-2017","11-8-2017")
      b_num = pokemon_hotel.available_room
      pokemon_hotel.reserve_room(b_dates, b_num)
      b_num.num.must_equal 1

      c_dates = pokemon_hotel.date_range("11-4-2017","11-7-2017")
      c_num = pokemon_hotel.available_room
      #pokemon_hotel.reserve_room(c_dates, c_num)
      c_num.num.must_equal 2

      s_dates = pokemon_hotel.date_range("11-7-2017","11-9-2017")
      s_num = pokemon_hotel.available_room
      pokemon_hotel.reserve_room(s_dates, s_num)
      c_num.num.must_equal 2
    end
  end

  describe "total" do
    it "returns the total cost of the stay" do
      charizard_chars = Hotel::Reservation.new
      d = charizard_chars.date_range("12-5-2017","12-10-2017")
      num = charizard_chars.available_room
      charizard_chars.reserve_room(d, num)
      charizard_chars.total.must_equal "$1000.00"
    end
    it "returns $200 if the stay was one night" do
      charizard_chars = Hotel::Reservation.new
      d = charizard_chars.date_range("12-5-2017","12-6-2017")
      num = charizard_chars.available_room
      charizard_chars.reserve_room(d, num)
      charizard_chars.total.must_equal "$200.00"
    end
    it "returns $0 if the stay was zero nights" do
      charizard_chars = Hotel::Reservation.new
      d = charizard_chars.date_range("12-5-2017","12-5-2017")
      num = charizard_chars.available_room
      charizard_chars.reserve_room(d, num)
      charizard_chars.total.must_equal "$0.00"
    end
  end
  describe "reservations by date" do
    it "returns only reservations on specific dates" do
      pokemon_hotel = Hotel::Reservation.new

      b_dates = pokemon_hotel.date_range("11-5-2017","11-8-2017")
      b_num = pokemon_hotel.available_room
      pokemon_hotel.reserve_room(b_dates, b_num)

      c_dates = pokemon_hotel.date_range("11-4-2017","11-7-2017")
      c_num = pokemon_hotel.available_room
      pokemon_hotel.reserve_room(c_dates, c_num)

      s_dates = pokemon_hotel.date_range("11-7-2017","11-9-2017")
      s_num = pokemon_hotel.available_room
      pokemon_hotel.reserve_room(s_dates, s_num)

      pokemon_hotel.reservations_by_date("11-6-2017").must_be_instance_of Array
      pokemon_hotel.reservations_by_date("11-6-2017").length.must_equal 2
    end
  end
  describe "available rooms during date range" do
    it "provides an array of available rooms" do
      pokemon_hotel = Hotel::Reservation.new
      #this room should open up as available
      slowbro_dates = pokemon_hotel.date_range("10-1-2017","10-4-2017")
      slowbro_num = pokemon_hotel.available_room
      pokemon_hotel.reserve_room(slowbro_dates, slowbro_num)
      #this room is not available
      teddiursa_dates = pokemon_hotel.date_range("10-4-2017","10-7-2017")
      teddiursa_num = pokemon_hotel.available_room
      pokemon_hotel.reserve_room(teddiursa_dates, teddiursa_num)
      #this room is available
      magikarp_dates = pokemon_hotel.date_range("10-7-2017","10-9-2017")
      magikarp_num = pokemon_hotel.available_room
      pokemon_hotel.reserve_room(magikarp_dates, magikarp_num)

      bellossum_dates = pokemon_hotel.date_range("10-4-2017", "10-6-2017")
      pokemon_hotel.available_rooms_during(bellossum_dates).length.must_equal 19
      pokemon_hotel.available_rooms_during(bellossum_dates).must_be_instance_of Array
    end
  end



end
