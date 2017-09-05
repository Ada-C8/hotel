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

    # it "Raises an error if room num isn't a valid num" do
    #   invalid_nums = ["cat", nil, 3.14, -1, 0, Hotel::NUM_ROOMS + 1]
    #   check_in = Date.new(2017,9,5)
    #   check_out = Date.new(2017,9,8)
    #
    #   invalid_nums.each do |not_num|
    #     proc { Hotel::Reservation.new(check_in, check_out, not_num) }.must_raise ArgumentError
    #   end
    # end
  end
end
