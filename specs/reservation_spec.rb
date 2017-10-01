require_relative 'spec_helper'

describe "Testing Reservation class" do

  let(:room) { Hotel::Room.new(4) }
  let(:res) { Hotel::Reservation.new(Date.today, Date.today + 2, Hotel::Room.new(5)) }
  let(:today) { Date.today }
  let(:two_days_later) { Date.today + 2 }

  describe "#initialize" do

    it "Creates a Reservation with a date range and room number" do

      res.check_in.must_equal today
      res.check_out.must_equal two_days_later
      res.room_num.must_equal 5

    end

    it "Creates a reservation_id that auto-increments based on length of @@all_reservations" do
      Hotel::Reservation.clear

      res1 = Hotel::Reservation.new(today, two_days_later, room)
      res1.reservation_id.must_equal 1

      res2 = Hotel::Reservation.new(today, two_days_later, Hotel::Room.new(1))
      res2.reservation_id.must_equal 2
    end

    describe "Testing Reservable mixin" do

      it "Raises an error if check in or check out aren't dates" do

        not_dates = ["cat", nil, 0, -3.14]

        not_dates.each do |invalid_input|
          proc { Hotel::Reservation.new(invalid_input, two_days_later, room) }.must_raise TypeError
        end

        not_dates.each do |invalid_input|
          proc { Hotel::Reservation.new(today, invalid_input, room) }.must_raise TypeError
        end

      end

      it "Raises an error if check in is before today's date" do
        proc { Hotel::Reservation.new(today.prev_day, today, room) }.must_raise ArgumentError
      end

      it "Raises an error if check out isn't later than check in " do
        proc { Hotel::Reservation.new(two_days_later, today) }.must_raise ArgumentError

        proc { Hotel::Reservation.new(today, today) }.must_raise ArgumentError
      end

    end

  end

  describe "#self.clear" do
    it "Clears all Reservation instances from the all_reservations array" do
      Hotel::Reservation.clear
      Hotel::Reservation.all.must_equal []

      new_res = Hotel::Reservation.new(today, two_days_later, room)
      Hotel::Reservation.all.must_equal [new_res]

      Hotel::Reservation.clear
      Hotel::Reservation.all.must_equal []
    end
  end

  describe "#self.all" do
    it "Returns a list of all Reservation instances" do
      Hotel::Reservation.clear

      res1 = Hotel::Reservation.new(today, two_days_later, room)
      Hotel::Reservation.all.must_equal [res1]

      res2 = Hotel::Reservation.new(today, two_days_later, Hotel::Room.new(1))
      Hotel::Reservation.all.must_equal [res1, res2]
    end
  end

  describe "#self.find(id)" do
    before do
      Hotel::Reservation.clear

      @res_to_find = Hotel::Reservation.new(today, two_days_later, room)
      Hotel::Reservation.new(today, two_days_later, Hotel::Room.new(1))

    end

    it "Returns a reservation matching the given reservation id" do
      Hotel::Reservation.find(1).must_equal @res_to_find
    end

    it "Returns nil if no reservation found with given id" do
      Hotel::Reservation.find(3).must_be_nil
    end
  end

  describe "#self.find_by_date" do
    it "Returns a list of reservations for a specific date (doesn't include checkout date)" do
      Hotel::Reservation.clear

      res1 = Hotel::Reservation.new(today, two_days_later, room)
      res2 = Hotel::Reservation.new(today, two_days_later + 1, Hotel::Room.new(1))

      Hotel::Reservation.find_by_date(today).must_equal [res1, res2]
      Hotel::Reservation.find_by_date(two_days_later).must_equal [res2]
      Hotel::Reservation.find_by_date(today + 4).must_equal []
    end

    it "Raises an error if date isn't a Date object" do
      invalid_dates = ["cat", [], nil, 4]

      invalid_dates.each do |invalid_date|
        proc { Hotel::Reservation.find_by_date(invalid_date) }.must_raise TypeError
      end
    end
  end

  describe "#total_cost" do

    it "Returns the total cost of the reservation" do

      res = Hotel::Reservation.new(today, two_days_later, room)
      expected_cost = 400 # 2 nights @ 200/night
      res.total_cost.must_equal expected_cost

      room.rate = 300
      more_expensive_res = Hotel::Reservation.new(two_days_later, two_days_later + 2, room)
      higher_cost = 600 # 2 nights @ 300/night
      more_expensive_res.total_cost.must_equal higher_cost

    end

    it "Returns the total discounted cost of the reservation if the room is in a block" do
      block = Hotel::Block.new(today, two_days_later, 0.8, [room])
      block_res = block.reserve(room)
      expected_cost = 320 # 0.8 * 200/night * 2 nights
      block_res.total_cost.must_equal expected_cost

      new_block = Hotel::Block.new(two_days_later, two_days_later + 1, 0.7, [room])
      new_block_res = new_block.reserve(room)
      new_cost = 140 #0.7 * 200/night * 1 night
      new_block_res.total_cost.must_equal new_cost
    end

  end

end
