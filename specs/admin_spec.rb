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

    room_nums = 1
    check_in = Date.new(2017,2,3)
    check_out = Date.new(2017, 2,7)
    @admin.add_reservation(room_nums, check_in, check_out)
  end

  describe "initialize" do
    it "@reservations returns reservations array" do
      @admin.reservations.must_be_kind_of Array
    end

    # it "@reservations array is empty" do
    #   @admin.reservations.must_be_empty
    # end

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
      @admin.room_nums.first.wont_equal ("!"..")")
    end

    describe "List of rooms method" do
      it "returns of all rooms" do
        @admin.list_of_rooms.must_be_kind_of Array
      end

    end


    #  it "Admin responds to room_nums method" do
    #    @admin.room_nums.must_respond_to :room_nums
    #  end
  end # end initialize

  describe "add_reservation" do
    it "thing that is added is a reservation" do
      @admin.reservations[0].must_be_instance_of Hotel::Reservation
    end

    it "verify reservation is added to array" do
      @admin.reservations.length.must_equal 1
    end
  end

  describe "list_reservations tests" do
    it "list test" do
      date = Date.new(2017, 2, 4)
       @admin.list_reservations(date).must_be_instance_of Array

      date = Date.new(2017, 2, 9)
     @admin.list_reservations(date).wont_be_instance_of Hotel::Reservation
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
