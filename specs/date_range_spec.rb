require_relative 'spec_helper'

describe 'DateRange' do

  before(:all) do
    @check_in = Date.new(2017, 03, 11)
    @check_out = Date.new(2017, 03, 15)
  end

  describe "initialize" do
    it "creates a new instance of DateRange" do
      DateRange.new(@check_in, @check_out).must_be_instance_of DateRange
    end

    it "raises an argument error if check_out date is before check_in" do
      check_in = Date.new(2017, 04, 11)
      proc { DateRange.new(check_in, @check_out)}.must_raise ArgumentError
    end

    it "does not raise an argument error if check_out date is after check_in" do
      check_out = Date.new(2017, 04, 11)
      # proc { DateRange.new(check_in, check_out)}.wont_throw Exception
      DateRange.new(@check_in, check_out).must_be_instance_of DateRange
    end
  end

    describe "nights" do
      it "provides the nights of stay" do
        stay = DateRange.new(@check_in, @check_out)
        stay.nights.must_equal 4
      end
    end

    describe "include?" do
      it "returns true if date is included in range" do
        date_to_check = Date.new(2017, 03, 12)
        stay = DateRange.new(@check_in, @check_out)
        stay.include?(date_to_check).must_equal true
      end

      it "returns false if date is not included in range" do
        date_to_check = Date.new(2017, 03, 15)
        stay = DateRange.new(@check_in, @check_out)
        stay.include?(date_to_check).must_equal false
      end
    end

    describe "overlap?" do
      it "returns true if date ranges overlap" do
        check_in = Date.new(2017, 03, 8)
        check_out = Date.new(2017, 03, 22)
        stay = DateRange.new(check_in, check_out)
        stay.overlap?(@check_in, @check_out).must_equal true
      end

      it "returns false if date ranges do not overlap" do
        check_in = Date.new(2017, 03, 15)
        check_out = Date.new(2017, 03, 22)
        stay = DateRange.new(check_in, check_out)
        stay.overlap?(@check_in, @check_out).must_equal false
      end
    end


  end

  #   it "initialize with all rooms in hotel as array" do
  #     Hotel.new.rooms.must_be_kind_of Array
  #   end
  #
  #   it "room array elements range from 1 to 20" do
  #     small_hotel = Hotel.new
  #     small_hotel.rooms[0].must_equal 1
  #     small_hotel.rooms[19].must_equal 20
  #   end
  #
  #   it "can access list of all rooms in hotel" do
  #     hotel_list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
  #     Hotel.new.rooms.must_equal hotel_list
  #
  #   end
  # end
