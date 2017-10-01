require_relative './spec_helper.rb'

describe "Wave 3: Blocks" do
  describe "Initialize" do

    it "can initialize a block" do
      new_hotel = Hotels::Hotel.new
      dates = Hotels::Reservations.check_dates([2020, 9, 10], [2020, 9, 12])
      date_range = Hotels::Reservations.date_range(dates)
      number_of_rooms = 5
      blocks = new_hotel.make_blocks(date_range, number_of_rooms)
      new_block = Hotels::Block.new(date_range, blocks)


      new_block.must_be_instance_of Hotels::Block

    end
  end
  describe "make_reservation" do

    it "can reserve a room from a block" do
      new_hotel = Hotels::Hotel.new
      dates = Hotels::Reservations.check_dates([2020, 9, 10], [2020, 9, 12])
      date_range = Hotels::Reservations.date_range(dates)
      number_of_rooms = 5
      blocks = new_hotel.make_blocks(date_range, number_of_rooms)
      new_block = Hotels::Block.new(date_range, blocks)

      blocks.must_be_instance_of Array
      blocks[0].must_be_instance_of Hotels::Rooms
      blocks.length.must_equal 5

      new_block.must_be_instance_of Hotels::Block
      new_block.block_of_rooms.length.must_equal 5

      reserved_room = new_block.make_reservation
      new_block.reservations.must_equal 1

      reserved_room2 = new_block.make_reservation
      reserved_room3 = new_block.make_reservation
      reserved_room4 = new_block.make_reservation
      reserved_room5 = new_block.make_reservation

      new_block.reservations.must_equal 5
      proc {new_block.make_reservation}.must_raise ArgumentError

    end

    describe "list_unbooked_rooms" do
      it "can list booked rooms within a block" do
        new_hotel = Hotels::Hotel.new
        dates = Hotels::Reservations.check_dates([2020, 9, 10], [2020, 9, 12])
        date_range = Hotels::Reservations.date_range(dates)
        number_of_rooms = 5
        blocks = new_hotel.make_blocks(date_range, number_of_rooms)
        new_block = Hotels::Block.new(date_range, blocks)
        reserved_room = new_block.make_reservation

        unbooked_rooms = new_block.list_unbooked_rooms
        unbooked_rooms.length.must_equal 4
        unbooked_rooms[0].must_be_instance_of Hotels::Rooms
        unbooked_rooms[-1].must_equal blocks[-1]
      end
    end

    describe "cost_of_reservation" do
      it "can calculate cost of reservation" do
        new_hotel = Hotels::Hotel.new
        dates = Hotels::Reservations.check_dates([2020, 9, 10], [2020, 9, 12])
        date_range = Hotels::Reservations.date_range(dates)
        number_of_rooms = 5
        blocks = new_hotel.make_blocks(date_range, number_of_rooms)
        new_block = Hotels::Block.new(date_range, blocks)
        reserved_room = new_block.make_reservation

        cost = new_block.cost_of_reservation(blocks[0])
        cost.must_equal 200

      end
    end

  end




end
