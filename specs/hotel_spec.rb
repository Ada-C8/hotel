require_relative "spec_helper"

describe "Hotel class" do
  describe "initialize" do
    it "exists" do
    Hotel::Hotel.new.must_be_instance_of Hotel::Hotel
    end
  end

  describe "available room" do
    it "provides an instance of the first available room" do
      pikachu_requests = Hotel::Hotel.new
      pikachu_requests.available_room.must_be_instance_of Hotel::Room
      pikachu_requests.available_room.num.must_equal 1
    end
  end

  describe "reserve room" do
    it "creates a reservation" do
      ash_says = Hotel::Hotel.new
      # d = ash_says.date_range("10-1-2017","10-5-2017")
      num = ash_says.available_room
      ash_says.reserve_room("10-1-2017", "10-5-2017", num).must_be_instance_of Array
    end
    it "adds to Hotels' reservations array" do
      oddish_asks = Hotel::Hotel.new
      oddish_asks.reservations.length.must_equal 0
      num = oddish_asks.available_room
      oddish_asks.reserve_room("10-1-2017","10-5-2017", num)
      oddish_asks.reservations.length.must_equal 1
    end
    it "works w/ reserve room to add reservations to different room numbers" do
      pokemon_hotel = Hotel::Hotel.new

      b_num = pokemon_hotel.available_room
      pokemon_hotel.reserve_room("11-5-2017","11-8-2017", b_num)
      b_num.num.must_equal 1

      c_num = pokemon_hotel.available_room
      #line below is purposefully commented out, shows reserved_room adds to @reservations
      #pokemon_hotel.reserve_room(c_dates, c_num)
      c_num.num.must_equal 2

      s_num = pokemon_hotel.available_room
      pokemon_hotel.reserve_room("11-7-2017","11-9-2017", s_num)
      c_num.num.must_equal 2
    end
  end


  # describe "reservations by date" do
  #   it "returns only reservations on specific dates" do
  #     pokemon_hotel = Hotel::Hotel.new
  #
  #     b_num = pokemon_hotel.available_room
  #     pokemon_hotel.reserve_room("11-5-2017","11-8-2017", b_num)
  #
  #     c_num = pokemon_hotel.available_room
  #     pokemon_hotel.reserve_room("11-4-2017","11-7-2017", c_num)
  #
  #     s_num = pokemon_hotel.available_room
  #     pokemon_hotel.reserve_room("11-7-2017","11-9-2017", s_num)
  #
  #     pokemon_hotel.reservations_by_date("11-6-2017").must_be_instance_of Array
  #     pokemon_hotel.reservations_by_date("11-6-2017").length.must_equal 2
  #   end
  # end
  # describe "available rooms during date range" do
  #   it "provides an array of available rooms" do
  #     pokemon_hotel = Hotel::Hotel.new
  #     #this room should open up as available
  #     slowbro_num = pokemon_hotel.available_room
  #     pokemon_hotel.reserve_room("10-1-2017","10-4-2017", slowbro_num)
  #     #this room is not available
  #     teddiursa_num = pokemon_hotel.available_room
  #     pokemon_hotel.reserve_room("10-4-2017","10-7-2017", teddiursa_num)
  #     #this room is available
  #     magikarp_num = pokemon_hotel.available_room
  #     pokemon_hotel.reserve_room("10-7-2017","10-9-2017", magikarp_num)
  #
  #     pokemon_hotel.available_rooms_during("10-4-2017", "10-6-2017").length.must_equal 19
  #     pokemon_hotel.available_rooms_during("10-4-2017", "10-6-2017").must_be_instance_of Array
  #   end
  #   it "returns an argument error if room entered is unavailable" do
  #     pokemon_hotel = Hotel::Hotel.new
  #
  #     slowbro_num = pokemon_hotel.available_room
  #     pokemon_hotel.reserve_room("1-18-2018","2-1-2018", slowbro_num)
  #
  #     proc { pokemon_hotel.reserve_room("1-19-2018", "1-20-2018", 1) }.must_raise ArgumentError
  #   end
  # end

end
