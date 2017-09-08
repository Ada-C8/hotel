require_relative 'spec_helper.rb'
require 'pry'

describe 'Admin class' do
  before do
    @administrator = Hotel::Admin.new
  end

  describe 'Initialize' do
    it "Can be create" do
      @administrator.must_be_instance_of Hotel::Admin
    end

    it "Create list of Reservation" do
      @administrator.list_reservations.must_equal []
    end

    it "Create a hash of rooms" do
      @administrator.rooms.must_be_instance_of Hash
    end

    it "Length of rooms is 20" do
      @administrator.rooms.length.must_equal 20
    end
  end

  describe "Creates a new reservation" do
    before do
      @day1 = Date.new(2017, 8, 29)
      @day2 = Date.new(2017, 9, 3)
    end

    it "Creates areservation when it is possible" do
      @administrator.add_reservation(@day1,@day2).must_be_instance_of Hotel::Reservation
    end

    it "Stores the new reservations in the list_reservations" do
      day3 = Date.new(2017,12,7)
      day4 = Date.new(2017,12,12)
      day5 = Date.new(2017,12,24)
      @administrator.add_reservation(@day1,@day2)
      @administrator.add_reservation(day3,day4)
      @administrator.add_reservation(day4,day5)
      @administrator.list_reservations.length.must_equal 3
    end

    it "Modify the rooms hash" do
        day3 = Date.new(2017,12,7)
        day4 = Date.new(2017,12,12)
        day5 = Date.new(2017,12,24)
        @administrator.add_reservation(@day1,@day2)
        @administrator.add_reservation(day3,day4)
        @administrator.add_reservation(day4,day5)
        @administrator.rooms["1"].length.must_equal 3
        @administrator.add_reservation(day4,day5)
        @administrator.rooms["2"].length.must_equal 1
        @administrator.rooms["3"].length.must_equal 0
    end

    it "doesn't create a new reservation if there is not rooms" do
      20.times do
        @administrator.add_reservation(@day1,@day2)
      end
      @administrator.add_reservation(@day1,@day2).must_equal "There is not avaliable rooms for that date range"
    end



  end

  describe "reservations_per_day" do
    before do
      @date1 = Date.new(2018,01,25)
      @date2 = Date.new(2018,02,22)
      @date3 = Date.new(2018,01,31)
      @date4 = Date.new(2018,02,05)
      @date5 = Date.new(2018,01,29)
      #@administrator = Hotel::Admin.new
      @administrator.add_reservation(@date1, @date3)
      @administrator.add_reservation(@date1, @date4)

      #terminar de hacer las reservaciones para los test

    end

    it 'Returns an array ' do
     @administrator.reservations_per_day(@date1).must_be_instance_of Array
    end

    it 'Returns an array of reservations instances' do
      @administrator.reservations_per_day(@date1)[0].must_be_instance_of Hotel::Reservation
    end

    it 'Returns all the reservations per day, when is not empty' do
      @administrator.reservations_per_day(@date1).length.must_equal 2
    end

    it 'Returns empty array if that day there is no reservations' do
      @administrator.reservations_per_day(@date2).must_equal []
    end
  end

  describe "avaliable_rooms_daterange" do
    before do
      @day1 = Date.new(2017,12, 13)
      @day2 = Date.new(2017,12, 19)
      @day3 = Date.new(2017,12,7)
      @day4 = Date.new(2017,12,12)
      @day5 = Date.new(2017,12,24)
      @day6 = Date.new(2017,12,14)
      @day7 = Date.new(2017,12,16)
      @all_rooms = []
      20.times do |i|
        @all_rooms << "#{i+1}"
      end
    end

    it "returns all the  rooms if there is 0 reservations for that date range" do
      @administrator.avaliable_rooms_daterange(@day1, @day2).must_equal @all_rooms
    end

    it "returns the rigth number of rooms avaliables" do
      3.times do
        @administrator.add_reservation(@day1, @day2)
      end
      @administrator.add_reservation(@day3,@day4)
      @administrator.add_reservation(@day1,@day5)
      @administrator.avaliable_rooms_daterange(@day6,@day7).must_equal @all_rooms[4..19]
    end
  end

end#describe class
