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

test_ob = Hotel::Admin.new

puts "This is a block #{test_ob.add_block([1,2,3,4], Date.new(2017,2,3), Date.new(2017, 2,7))}"

puts "List of available rooms #{test_ob.list_vacancies(Date.new(2017,2,3), Date.new(2017, 2,7))}"

puts test_ob.create_block_by_date(4, Date.new(2017,2,3), Date.new(2017, 2,7))

puts "List of available rooms #{test_ob.list_vacancies(Date.new(2017,2,3), Date.new(2017, 2,7))}"

xdescribe "Admin Class" do

  before do

    @admin = Hotel::Admin.new

    rooms_per_block = 4
    rooms_per_block.must_be_kind_of Integer
    rooms_per_block.wont_be_instance_of String

    check_in = Date.new(2017,2,3)
    check_in.must_be_instance_of Date

    check_out = Date.new(2017, 2,7)
    check_in.must_be_instance_of Date

    @admin.add_block(rooms_per_block, check_in, check_out, discount_percent: 0.0)
  end

  describe "initialize" do
    it "@blocks returns blocks array" do
      @admin.blocks.must_be_kind_of Array
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

    describe "List_of_rooms method" do
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

  xdescribe "add_block" do
    it "thing that is added is a block" do
      @admin.blocks[0].must_be_instance_of Hotel::Block
      @admin.blocks[-1].must_be_instance_of Hotel::Block

    end

    it "verify block is added to array" do
      @admin.blocks.length.must_equal 1
      @admin.blocks.length.wont_equal 2

    end
  end

  xdescribe "list_reservations tests" do
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
    check_in.must_be_instance_of Date

    check_out = Date.new(2017, 2, 5)
    check_in.must_be_instance_of Date

    @admin.list_vacancies(check_in, check_out).must_be_instance_of Array
    @admin.list_vacancies(check_in, check_out)[0].must_be_kind_of Integer
    @admin.list_vacancies(check_in, check_out)[-1].must_be_kind_of Integer

    # edge cases
    @admin.list_vacancies(check_in, check_out).wont_be_instance_of Hotel::Block
    @admin.list_vacancies(check_in, check_out).wont_be_kind_of Integer
    @admin.list_vacancies(check_in, check_out).wont_be_kind_of String
  end

  describe "reserve available room by date range" do
    it "validates input" do
      rooms_per_block = 4
      rooms_per_block.must_be_kind_of Integer

      check_in = Date.new(2017, 2, 4)
      check_in.must_be_instance_of Date

      check_out = Date.new(2017, 2, 5)
      check_in.must_be_instance_of Date

      @admin.must_respond_to :list_vacancies

      puts "this is the list of blocked rooms #{@admin.create_block_by_date(rooms_per_block, check_in, check_out)}"
      # @admin.create_block_by_date(rooms_per_block, check_in, check_out).total_cost.must_equal 200
      # @admin.create_block_by_date(rooms_per_block, check_in, check_out).wont_equal 0
    end
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

[]

Block
Discount (float)
Reservations (array)
Room number
dates
Date
Price
Name

=end
