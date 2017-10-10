require_relative 'spec_helper.rb'


describe "Room" do
  before do
    @room = Hotel::Room.new
    @room2 = Hotel::Room.new(400)
  end

  describe "Room class" do
    it "has a room class" do
      Hotel::Room.class.must_be_kind_of Class
    end
  end

  describe "@price" do
    it "return @price == 200 if no parameter is passed" do
      @room.price.must_equal 200
    end
    it "returns the price given" do
      @room2.price.must_equal 400
    end
  end

  describe "@bookings" do
    it "has a @booking variable" do
      @room.must_respond_to :bookings
    end
    it "has a @booking variable of the class array" do
      @room.bookings.must_be_kind_of Array
    end
    it "@booking variable is an array of hashes with :arrival and :departure keys and date objects as values" do
      room = Hotel::Room.new
      room.book("01-04-2017", "01-06-2017").must_equal true
      first_booking = room.bookings.first
      first_booking.must_be_kind_of Hash
      first_booking[:arrival].must_be_kind_of Date
      first_booking[:departure].must_be_kind_of Date
    end
  end

  describe "book" do
    it "has a book method" do
      @room.must_respond_to :book
    end
    it "has a book method that will return false of the room is already book and true if it's not" do
      room = Hotel::Room.new
      arrive = Date.strptime("01-01-2017",'%m-%d-%Y')
      leave = Date.strptime("01-04-2017",'%m-%d-%Y')
      room.bookings << {arrival: arrive, departure: leave}
      room.book("01-01-2017", "01-04-2017").must_equal false
      room.book("01-02-2017", "01-03-2017").must_equal false
      room.book("12-30-2016", "01-06-2017").must_equal false
      room.bookings << {arrival: arrive, departure: leave}
      room.book("01-05-2017", "01-06-2017").must_equal true
      room.book("01-04-2017", "01-06-2017").must_equal true
      room.book("12-30-2016", "01-01-2017").must_equal true
      room.book("12-30-2016", "01-01-2017").must_equal false
    end
    it "only successful bookings get saved in the @bookings array" do
      room = Hotel::Room.new
      room.book("01-05-2017", "01-06-2017")
      room.book("01-05-2017", "01-06-2017")

      room.book("01-04-2017", "01-06-2017")
      room.book("01-04-2017", "01-06-2017")
      
      room.book("12-30-2016", "01-01-2017")
      room.book("12-30-2016", "01-01-2017")

      room.bookings.length.must_equal 3
    end
  end



end
