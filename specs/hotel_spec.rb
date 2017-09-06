require_relative 'spec_helper'

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
  end # end of make and retrieve reservations

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

    #[]     ##########COME BACK TO THIS!! ##############
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



end
