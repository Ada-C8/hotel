require_relative '../specs/spec_helper'

=begin
Each room should have a room number.
- pass in the room number to the room object.
- to automate making all 20 rooms we need a times loop from 1-20.
- set an iterative variable to 1.
=end

# Hotel
#   Admin
#     Reservations

describe "Admin Class" do

  before do

    @admin = Hotel::Admin.new

    room_num = 1
    room_num.must_be_kind_of Integer
    room_num.wont_be_instance_of String

    check_in = Date.new(2017,2,3)
    check_in.must_be_instance_of Date

    check_out = Date.new(2017, 2,7)
    check_in.must_be_instance_of Date

    @admin.add_reservation(room_num, check_in, check_out)
  end

  describe "initialize" do
    it "@reservations returns reservations array" do
      @admin.reservations.must_be_kind_of Array
    end

    it "@room_nums returns an array" do
      @admin.room_nums.must_be_kind_of Array
    end

    it "@room_nums is between 1-20" do
      # normative classes
      @admin.room_nums.first.must_equal 1
      @admin.room_nums.last.must_equal 20

      # edge classes
      @admin.room_nums.first.wont_equal 0
      @admin.room_nums.last.wont_equal 21
      @admin.room_nums.first.wont_be_instance_of String
      @admin.room_nums.last.wont_be_instance_of String
    end

    describe "List of rooms method" do
      it "returns of all rooms" do
        @admin.room_nums.must_be_kind_of Array
        @admin.list_of_rooms.must_be_kind_of Array

        # normative classes
        @admin.list_of_rooms.first.must_equal 1
        @admin.list_of_rooms.last.must_equal 20

        # edge classes
        @admin.list_of_rooms.first.wont_equal 0
        @admin.list_of_rooms.last.wont_equal 21
        @admin.room_nums.first.wont_be_instance_of String
        @admin.room_nums.last.wont_be_instance_of String
      end
    end
  end # end initialize

  describe "add_reservation" do
    it "thing that is added is a reservation" do
      @admin.reservations[0].must_be_instance_of Hotel::Reservation
      @admin.reservations[-1].must_be_instance_of Hotel::Reservation

    end

    it "verify reservation is added to array" do
      @admin.reservations.length.must_equal 1
      @admin.reservations.length.wont_equal 2

    end
  end

  describe "list_reservations tests" do
    it "list test" do
      date = Date.new(2017, 2, 4)
      date.must_be_instance_of Date
      @admin.list_reservations(date).must_be_instance_of Array
      @admin.list_reservations(date).first.must_be_instance_of Hotel::Reservation
      @admin.list_reservations(date).last.must_be_instance_of Hotel::Reservation

      # edge cases
      date = Date.new(2017, 2, 9)
      date.must_be_instance_of Date
      @admin.list_reservations(date).wont_be_instance_of Hotel::Reservation
      @admin.list_reservations(date).wont_be_kind_of Integer
      @admin.list_reservations(date).wont_be_kind_of String
    end
  end


  it "list_vacancies" do
    check_in = Date.new(2017, 2, 4)
    check_out = Date.new(2017, 2, 5)
    # x = Hotel::DateRange.new(check_in, check_out)
    @admin.list_vacancies(check_in, check_out)


    @admin.list_of_rooms
  end
end # end admin class

=begin

Reservations
Block
Discount
Reservations
Room number
dates
Date
Price
Name

=end

=begin

Block.new([rooms], [dates], discount)

Block
Discount (float)
Reservations (array)
Room number
dates
Date
Price
Name

=end
