require_relative 'spec_helper'

describe "Testing Reservation class" do
  describe "#initialize" do
    before do
      @room = Hotel::Room.new(4)
      @res = Hotel::Reservation.new(Date.today, Date.today + 3, @room)
    end

    it "Creates a Reservation with a date range and room number" do
      @res.check_in.must_be_instance_of Date
      @res.check_out.must_be_instance_of Date
      @res.room_num.must_be_kind_of Integer
    end

    describe "Testing Reservable methods" do

      it "Raises an error if check_out date isn't later than check_in date" do
        check_in = Date.today
        check_out = Date.new(2017,8,5)

        proc { Hotel::Reservation.new(check_in, check_out, @room) }.must_raise ArgumentError

        check_out = Date.today
        proc { Hotel::Reservation.new(check_in, check_out, @room) }.must_raise ArgumentError
      end

      it "Raises an error if check_in is before today's date" do
        proc { Hotel::Reservation.new(Date.today - 1, Date.today, @room) }.must_raise ArgumentError
      end

    end
    # move this to user interface
    # it "Raises an error if check in or check out aren't date objects or can't be parsed as dates" do
    #   not_dates = ["cat", nil, 0, "", -1]
    #   valid_date = '2017/9/5'
    #
    #   not_dates.each do |item|
    #     proc { Hotel::Reservation.new(valid_date, item, 20) }.must_raise ArgumentError
    #   end
    #
    #   not_dates.each do |item|
    #     proc {Hotel::Reservation.new(item, valid_date, 18) }.must_raise ArgumentError
    #   end
    #
    # end

  end

  describe "total_cost" do
    before do
      @check_in = Date.today
      @check_out = Date.today + 3
      @res = Hotel::Reservation.new(@check_in, @check_out, Hotel::Room.new(4))
    end

    it "Returns the total cost of the reservation" do
      num_nights = (@check_out - @check_in).to_i
      expected_cost = num_nights * (Hotel::Room::DEFAULT_RATE)

      @res.total_cost.must_equal expected_cost
    end

  end

  # describe "#self.find" do
  #   before do
  #     date_to_check = Date.new(2017,9,5)
  #   end
  #
  #   it "Returns a list of Reservations for a given date" do
  #
  #   end
  # end
end
