require_relative 'spec_helper.rb'

describe "Hotel" do

  before do
    @hotel = Hotel::Hotel.new(20)
  end

  describe "Hotel class" do

    it "is a class of the Hotel module" do
      Hotel::Hotel.class.must_equal Class
    end

    it "takes a readable number_of_rooms attribute " do
      @hotel.must_respond_to :number_of_rooms
      @hotel.number_of_rooms.must_equal 20
    end

    it "has a list_of_rooms attribute" do
      @hotel.must_respond_to :list_of_rooms
    end

    it "The list_of_rooms attribute that is an array of rooms" do
      @hotel.list_of_rooms.must_be_kind_of Array
      @hotel.list_of_rooms[0].must_be_kind_of Hotel::Room
      @hotel.list_of_rooms[0].number.must_equal 1
      @hotel.list_of_rooms[19].number.must_equal 20
      @hotel.list_of_rooms[20].must_be_nil
      @hotel.list_of_rooms[0].price.must_equal 200.00
    end

    it "has a make_reservation method" do
      @hotel.must_respond_to :make_reservation

    end

    it "has a reservations attribute" do
      @hotel.must_respond_to :reservations
    end

    it "The reservations attribute is an array of reservations" do
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.reservations.must_be_kind_of Array
      @hotel.reservations[0].client.must_equal "Marcel Luedtke"
      @hotel.reservations[0].stay_length.must_equal 2
    end

    it "The make_reservation method update the status of the rooms booked" do
      @hotel = Hotel::Hotel.new(20)
      @hotel.list_of_rooms[0].booked.must_be_empty
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.list_of_rooms[0].booked[0].must_be_kind_of Hash
      @hotel.list_of_rooms[0].booked[0]["arrival"].class.must_equal Date
      @hotel.list_of_rooms[0].booked[0]["arrival"].year.must_equal 2017
      @hotel.list_of_rooms[0].booked[0]["arrival"].mon.must_equal 9
      @hotel.list_of_rooms[0].booked[0]["arrival"].mday.must_equal 17
      @hotel.list_of_rooms[0].booked[0]["departure"].year.must_equal 2017
      @hotel.list_of_rooms[0].booked[0]["departure"].mon.must_equal 9
      @hotel.list_of_rooms[0].booked[0]["departure"].mday.must_equal 19
      @hotel.list_of_rooms[1].booked.must_be_empty
      @hotel = Hotel::Hotel.new(20)
      @hotel.make_reservation("Walter luedtke", 2017,9,17, 2017,9,19, 3)
      @hotel.list_of_rooms[0].booked[0].must_be_kind_of Hash
      @hotel.list_of_rooms[0].booked[0]["arrival"].class.must_equal Date
      @hotel.list_of_rooms[1].booked[0]["arrival"].class.must_equal Date
      @hotel.list_of_rooms[2].booked[0]["arrival"].class.must_equal Date
      @hotel.list_of_rooms[3].booked.must_be_empty
      @hotel.list_of_rooms[4].booked.must_be_empty
      @hotel.list_of_rooms[5].booked.must_be_empty
      @hotel.make_reservation("Alex luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.list_of_rooms[0].booked[0]["arrival"].class.must_equal Date
      @hotel.list_of_rooms[1].booked[0]["arrival"].class.must_equal Date
      @hotel.list_of_rooms[2].booked[0]["arrival"].class.must_equal Date
      @hotel.list_of_rooms[3].booked[0]["arrival"].class.must_equal Date
      @hotel.list_of_rooms[4].booked.must_be_empty
      @hotel.list_of_rooms[5].booked.must_be_empty
      @hotel = Hotel::Hotel.new(20)
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 20)
      proc {@hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)}.must_raise Hotel::NoAvailableRoomError
      @hotel = Hotel::Hotel.new(20)
      20.times do
        @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      end
      proc {@hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)}.must_raise Hotel::NoAvailableRoomError
    end

    it "has a reservations_by_date method" do
      @hotel = Hotel::Hotel.new(20)
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.must_respond_to :reservations_by_date
    end
    it "The reservations_by_date method returns an array of reservations for a given date" do
      @hotel = Hotel::Hotel.new(20)
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.make_reservation("marcel luedtke", 2017,9,20, 2017,9,21, 2)
      @hotel.reservations_by_date(2017,9,18).must_be_kind_of Array
      @hotel.reservations_by_date(2017,9,17).count.must_equal 1
      @hotel.reservations_by_date(2017,9,18).count.must_equal 1
      @hotel.reservations_by_date(2017,9,19).count.must_equal 0
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 2)
      @hotel.reservations_by_date(2017,9,18).count.must_equal 2
      @hotel.reservations_by_date(2017,9,18)[0].arrival_date.must_be :>=, Date.new(2017,9,17)
      @hotel.reservations_by_date(2017,9,18)[0].departure_date.must_be :<=, Date.new(2017,9,19)
    end

    it "has a available_at_date method" do
      @hotel = Hotel::Hotel.new(20)
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.must_respond_to :available_at_date
    end

    it "The available_at_date method returns an array of available rooms for a given date" do
      @hotel = Hotel::Hotel.new(20)
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.available_at_date(2017,9,18).must_be_kind_of Array
      @hotel.available_at_date(2017,9,18)[0].must_be_kind_of Hotel::Room
      @hotel.available_at_date(2017,9,18)[18].must_be_kind_of Hotel::Room
      @hotel.available_at_date(2017,9,18)[19].must_be_nil

      @hotel = Hotel::Hotel.new(20)
      20.times do
        @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      end
      @hotel.available_at_date(2017,9,18).must_equal "No avaibility at these dates."
    end

    it "has a available_at_period method" do
      @hotel = Hotel::Hotel.new(20)
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.must_respond_to :available_at_period
    end

    it "The available_at_period method returns an array of available rooms for a period of time" do
      @hotel = Hotel::Hotel.new(20)
      @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      @hotel.available_at_period(2017,9,18,2017,9,30).must_be_kind_of Array
      @hotel.available_at_period(2017,9,18,2017,9,30)[0].must_be_kind_of Hotel::Room
      @hotel.available_at_period(2017,9,18,2017,9,30)[18].must_be_kind_of Hotel::Room
      @hotel.available_at_period(2017,9,18,2017,9,30)[19].must_be_nil
      @hotel.available_at_period(2017,9,15,2017,9,17)[18].must_be_kind_of Hotel::Room
      @hotel.available_at_period(2017,9,15,2017,9,17)[19].must_be_nil
      @hotel.available_at_period(2017,9,19,2017,9,22)[18].must_be_kind_of Hotel::Room
      @hotel.available_at_period(2017,9,19,2017,9,22)[19].must_be_nil

      @hotel = Hotel::Hotel.new(20)
      20.times do
        @hotel.make_reservation("marcel luedtke", 2017,9,17, 2017,9,19, 1)
      end
      @hotel.available_at_period(2017,9,17, 2017,9,19).must_equal "No avaibility at these dates."
    end


  end




end
