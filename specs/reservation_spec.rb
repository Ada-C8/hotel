require_relative 'spec_helper.rb'

describe "Reservation" do
  before do
    @reservation = Hotel::Reservation.new("Marcel Luedtke", "2017/9/17", "2017/9/19", 1)
  end

  describe "Reservation class" do

    it "is a class of the Hotel module" do
      Hotel::Reservation.class.must_equal Class
    end

    it "can be instanciated" do
      @reservation.class.must_equal Hotel::Reservation
    end

  end

  describe "client attribute" do

    it "Reservation has a client attribute" do
      @reservation.must_respond_to :client
    end

    it "returns a capitalized string" do
      @reservation.client.class.must_equal String
      @reservation = Hotel::Reservation.new("marcel luedtke", "2017/9/17", "2017/9/19", 1)
      @reservation.client.must_equal "Marcel Luedtke"
    end

  end

  describe "arrival_date attribute" do
    it "Reservation has a date attribute" do
      @reservation.must_respond_to :arrival_date
    end

    it "returns a Date instance" do
      @reservation.arrival_date.class.must_equal Date
    end

    it "returns the correct date" do
      @reservation.arrival_date.year.must_equal 2017
      @reservation.arrival_date.month.must_equal 9
      @reservation.arrival_date.day.must_equal 17
    end
  end

  describe "departure_date attribute" do
    it "Reservation has a date attribute" do
      @reservation.must_respond_to :departure_date
    end

    it "returns a Date instance" do
      @reservation.departure_date.class.must_equal Date
    end

    it "returns the correct date" do
      @reservation.departure_date.year.must_equal 2017
      @reservation.departure_date.month.must_equal 9
      @reservation.departure_date.day.must_equal 19
    end
  end

  describe "stay_length method" do

    it "Reservation has a stay_length attribute" do
      @reservation.must_respond_to :stay_length
      @reservation.stay_length.must_be :==, 2
    end

    it "raise an argument error if the departure date is before the arrival date" do
      @reservation = Hotel::Reservation.new("marcel luedtke", "2017/9/18", "2017/9/17", 1.00)
      proc {@reservation.stay_length}.must_raise ArgumentError
    end

  end

  describe "number_of_rooms attribute" do
    it "Reservation has a number_of_rooms attribute" do
      @reservation.must_respond_to :number_of_rooms
    end

    it "returns an integer" do
      @reservation = Hotel::Reservation.new("marcel luedtke", "2017/9/17", "2017/9/19", 1.00)
      @reservation.number_of_rooms.class.must_equal Integer
    end

    it "returns the correct number of rooms" do
      @reservation = Hotel::Reservation.new("marcel luedtke", "2017/9/17", "2017/9/19", 3.00)
      @reservation.number_of_rooms.must_equal 3
    end
  end

  describe "total method" do

    it "Has a total method" do
      @reservation.must_respond_to :total
    end

    it "the total method return the correct total" do
      @reservation.total.must_equal 400.00
      @reservation = Hotel::Reservation.new("marcel luedtke", "2017/9/17", "2017/9/16", 1.00)
      proc {@reservation.total}.must_raise ArgumentError
      @reservation = Hotel::Reservation.new("marcel luedtke", "2017/9/17", "2017/9/17", 1.00)
      proc {@reservation.total}.must_raise ArgumentError
      @reservation = Hotel::Reservation.new("marcel luedtke", "2017/9/17", "2017/9/19", 2.00)
      @reservation.total.must_equal 800.00
    end
  end

  # describe "Summary method" do
  #
  #   it "has a summary method" do
  #     @reservation.must_respond_to :summary
  #     proc {@reservation.summary}.must_output "Name: Marcel Luedtke\nDate: From 2017-09-17 to 2017-09-19\nNumber of rooms: 1\nTotal price: 400.0"
  #   end
  # end

end
