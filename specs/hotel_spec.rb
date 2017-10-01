require_relative 'spec_helper'

describe 'Hotel' do
  let(:my_hotel) {Hotel_System::Hotel.new(20)}
  let(:check_in) {Date.new(2017,9,5)}
  let(:check_out) {Date.new(2017,9,7)}
  let(:date_to_find) {Date.new(2017,9,6)}
  let(:date_without_res) {Date.new(2017,9,7)}

  describe '#initialize' do
    it 'takes number of rooms as a parameter when initialized' do
      my_hotel.number_of_rooms.must_equal 20
    end

    it 'creates an array of room objects when initialized' do
      my_hotel.rooms.must_be_instance_of Array
      my_hotel.rooms.each { |room| room.must_be_instance_of Hotel_System::Room }
    end

    it 'creates an empty collection of reservations' do
      my_hotel.reservations.must_be_instance_of Array
    end
  end

  describe 'reservations' do
    it "combines room reservation arrays into an array of all hotel reservations" do
      my_hotel.rooms[0].reserve(check_in, check_out)
      my_hotel.reservations.length.must_equal 1

      my_hotel.rooms[19].reserve(check_in, check_out)
      my_hotel.reservations.length.must_equal 2
    end
  end

  describe '#find_res_by_date' do
    it "returns an array of reservations whose duration includes given date" do
      my_hotel.rooms[0].reserve(check_in, check_out)
      my_hotel.rooms[19].reserve(check_in, check_out)

      my_hotel.find_res_by_date(date_to_find).must_be_instance_of Array
      my_hotel.find_res_by_date(date_to_find).length.must_equal 2
      my_hotel.find_res_by_date(date_without_res).must_equal []
    end

    describe "#find_avail_rooms" do
      before do
        10.times {|i| my_hotel.rooms[i].reserve(check_in, check_out)}
      end

      it "returns a list of room objects" do
        my_hotel.find_avail_rooms(check_in, check_out).must_be_instance_of Array
        my_hotel.find_avail_rooms(check_in, check_out).length.must_equal 10
        my_hotel.find_avail_rooms(check_in, check_out).each {|room| room.must_be_instance_of Hotel_System::Room}
      end

      it "does not list rooms already reserved for a given date" do
        my_hotel.find_avail_rooms(check_in, check_out).wont_include my_hotel.rooms[0]
        my_hotel.find_avail_rooms(check_in, check_out).wont_include my_hotel.rooms[9]
      end
    end

    describe "create_block" do
      it 'does not allow block creation if there are not enough available rooms' do
        20.times { |i| my_hotel.rooms[i].reserve(check_in, check_out)}
        proc {my_hotel.create_block(check_in, check_out, 1, 0.70)}.must_raise ArgumentError
      end

      it 'does not allow creation of a block with more than 5 rooms' do
        proc {my_hotel.create_block(check_in, check_out, 6, 0.70)}.must_raise ArgumentError
      end

      it 'returns an array containing all the Blocks in Hotel' do
        my_hotel.create_block(check_in, check_out, 1, 0.70).must_be_instance_of Array
        my_hotel.blocks.each {|block| block.must_be_instance_of Hotel_System::Block}
      end

      it 'makes its constituent rooms unavailable' do
        my_hotel.create_block(check_in, check_out, 1, 0.70)
        my_hotel.blocks[0].rooms.each {|room| room.available?(check_in, check_out).must_equal false}
        proc {my_hotel.rooms[0].reserve}.must_raise ArgumentError
      end
    end
  end
end
