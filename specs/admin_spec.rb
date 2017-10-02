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

    rooms_per_block = 4
    rooms_per_block.must_be_kind_of Integer

    check_in = Date.new(2017,2,3)
    check_in.must_be_instance_of Date

    check_out = Date.new(2017, 2,7)
    check_in.must_be_instance_of Date

    block_id = 1

    @admin.create_block_by_date(rooms_per_block, check_in, check_out, block_id, discount_percent: 0.0)

    @admin.add_reservation_to_block(1, 1, check_in, check_out, discount_percent: 0)


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
      # @admin.room_nums.first.wont_equal 0
      # @admin.room_nums.last.wont_equal 21
      # @admin.room_nums.first.wont_be_instance_of String
      # @admin.room_nums.last.wont_be_instance_of String
    end

    describe "List_of_rooms method" do
      it "returns of all rooms" do
        @admin.room_nums.must_be_kind_of Array
        @admin.list_of_rooms.must_be_kind_of Array

        # normative classes
        @admin.list_of_rooms.first.must_equal 1
        @admin.list_of_rooms.last.must_equal 20

        # edge classes
        # @admin.list_of_rooms.first.wont_equal 0
        # @admin.list_of_rooms.last.wont_equal 21
        # @admin.room_nums.first.wont_be_instance_of String
        # @admin.room_nums.last.wont_be_instance_of String
      end
    end
  end # end initialize

  describe "add_block" do
    it "thing that is added is a block" do
      @admin.blocks[0].must_be_instance_of Hotel::Block
      @admin.blocks[-1].must_be_instance_of Hotel::Block


    end

    it "verify block is added to array" do
      @admin.blocks.length.must_equal 1


    end
  end

  describe "list_reservations tests" do
    it "list test" do
      date = Date.new(2017, 2, 4)
      date.must_be_instance_of Date

      test_ob = @admin.add_reservation_to_block(1,1, Date.new(2017,2,2), Date.new(2017,2,7), discount_percent: 0)

      @admin.list_reservations(date).must_be_instance_of Array
      @admin.list_reservations(date).first.must_be_instance_of Hotel::Reservation
      @admin.list_reservations(date).last.must_be_instance_of Hotel::Reservation

      # edge cases
      date = Date.new(2017, 2, 9)
      date.must_be_instance_of Date

    end
  end


  it "list_vacancies" do
    check_in = Date.new(2017, 2, 4)
    check_in.must_be_instance_of Date

    check_out = Date.new(2017, 2, 5)
    check_in.must_be_instance_of Date

    @admin.list_vacancies(check_in, check_out).must_be_instance_of Array
    # @admin.list_vacancies(check_in, check_out)[0].must_be_kind_of Integer
    @admin.list_vacancies(check_in, check_out)[-1].must_be_kind_of Integer

    # edge cases


  end



  describe "create block by date range" do
    it "validates input" do
      rooms_per_block = 4
      rooms_per_block.must_be_kind_of Integer

      check_in = Date.new(2017, 2, 4)
      check_in.must_be_instance_of Date

      check_out = Date.new(2017, 2, 5)
      check_in.must_be_instance_of Date

      block_id = 2
      block_id.must_be_kind_of Integer

      @admin.create_block_by_date(rooms_per_block, check_in, check_out,block_id)

      @admin.must_respond_to :list_vacancies

      @admin.blocks.length.must_equal 2
    end

    it "Raise an error for no more available rooms" do
      proc { Hotel::Admin.create_block_by_date(rooms_per_block, check_in, check_out, block_id)}.must_raise StandardError
    end


    describe "find_block" do
      it "takes integer id" do
        id = 1
        @admin.find_block(id).must_be_kind_of Hotel::Block

        @admin.find_block(id).must_be_kind_of Hotel::Block

        @admin.find_block(id).wont_be_kind_of String


        id = 0
        @admin.find_block(id).wont_be_kind_of Hotel::Block
      end

      it "returns block object" do
        @admin.find_block(1).must_be_instance_of Hotel::Block
      end
    end

    describe "list_available_blocked_rooms" do
      it "returns an array with room numbers" do
        @admin.list_available_blocked_rooms(1).must_be_instance_of Array
        @admin.list_available_blocked_rooms(1).first.must_be_kind_of Integer
        @admin.list_available_blocked_rooms(1).last.must_be_kind_of Integer


        #edge cases


      end
    end

    describe "find_rooms_from_block" do
      it "returns array of a specific block's rooms" do
        @admin.find_rooms_from_block(1, 4).must_be_kind_of Array
        @admin.find_rooms_from_block(1, 4).first.must_equal 1
        @admin.find_rooms_from_block(1, 4).last.must_equal 4
      end
    end

    describe "add_reservation_to_block" do

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
