require_relative 'spec_helper'

describe "Testing Reservation class" do
  describe "#initialize" do
    before do
      @res = Hotel::Reservation.new(Date.new(2017,9,4), Date.new(2017,9,7), 4)
    end

    it "Creates a Reservation with a date range and room number" do
      @res.check_in.must_be_instance_of Date
      @res.check_out.must_be_instance_of Date
      @res.room_num.must_be_kind_of Integer
    end

    it "Raises an error if check_out date isn't later than check_in date" do
      check_in = Date.new(2017,9,5)
      check_out = Date.new(2017,8,5)

      proc { Hotel::Reservation.new(check_in, check_out, 2) }.must_raise ArgumentError

      check_out = Date.new(2017,9,5)
      proc { Hotel::Reservation.new(check_in, check_out, 2) }.must_raise ArgumentError
    end

  end

  describe "total_cost" do
    before do
      @check_in = Date.new(2017,9,5)
      @check_out = Date.new(2017,9,8)
      @res = Hotel::Reservation.new(@check_in, @check_out, 4)
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
