require_relative 'spec_helper'

describe "DateRange" do

  let(:date) { BookingSystem::DateRange.new('2001-02-05', '2001-02-10') }
  let(:hotel) { BookingSystem::Hotel.new }

  describe "#initialize" do
    it "should create an instance of DateRange" do
      date.must_be_instance_of BookingSystem::DateRange

      date.must_respond_to :check_in
      date.check_in.must_be_instance_of Date

      date.must_respond_to :check_out
      date.check_out.must_be_instance_of Date
    end
  end # Describe

  describe "#overlap" do
    it "should return booked rooms if dates front overlap existing reservations" do
      hotel.create_reservation("Bob", '2001-02-05', '2001-02-10')
      date_front = BookingSystem::DateRange.new('2001-02-02', '2001-02-07')

      date_front.overlap(hotel.all_reservations).must_equal [1]
    end

    it "should return booked rooms if dates back overlap exisiting reservations" do
      hotel.create_reservation("Bob", '2001-02-05', '2001-02-10')
      date_back = BookingSystem::DateRange.new('2001-02-08', '2001-02-13')

      date_back.overlap(hotel.all_reservations).must_equal [1]
    end

    it "should return booked rooms if requested dates are completely contained in existing reservations" do
      hotel.create_reservation("Bob", '2001-02-05', '2001-02-10')
      date_contained = BookingSystem::DateRange.new('2001-02-06', '2001-02-09')

      date_contained.overlap(hotel.all_reservations).must_equal [1]
    end

    it "should return no booked rooms if requested dates are completely before existing reservations" do
      hotel.create_reservation("Bob", '2001-02-05', '2001-02-10')
      date_before = BookingSystem::DateRange.new('2001-02-01', '2001-02-04')

      date_before.overlap(hotel.all_reservations).must_be_empty
    end

    it "should return no booked rooms if requested dates are completely after existing reservations" do
      hotel.create_reservation("Bob", '2001-02-05', '2001-02-10')
      date_after = BookingSystem::DateRange.new('2001-02-11', '2001-02-14')

      date_after.overlap(hotel.all_reservations).must_be_empty
    end

    it "should return booked rooms if requested checkout date ends on exisiting checkin date" do
      hotel.create_reservation("Bob", '2001-02-05', '2001-02-10')
      date = BookingSystem::DateRange.new('2001-02-01', '2001-02-05')

      date.overlap(hotel.all_reservations).must_equal [1]
    end

    it "should return no booked rooms if requested checkin date is the same as the exisiting reservations checkout date" do
      hotel.create_reservation("Bob", '2001-02-05', '2001-02-10')
      date = BookingSystem::DateRange.new('2001-02-10', '2001-02-14')

      date.overlap(hotel.all_reservations).must_be_empty
    end
  end # Describe

  describe "#valid?" do
    it "should raise an ArgumentError if checkin date is before checkout date" do
      date = BookingSystem::DateRange.new('2001-02-05', '2001-02-02')
      proc { date.valid_dates? }.must_raise ArgumentError
    end
  end # Describe

end # Describe
