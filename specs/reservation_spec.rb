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

  describe "#self.find" do
    it "Returns a reservation matching the given reservation_id" do

    end
  end

  describe "total_cost (in Reservable)" do
    # before do
    #   @check_in = Date.today
    #   @check_out = Date.today + 3
    #   @res = Hotel::Reservation.new(@check_in, @check_out, Hotel::Room.new(4))
    # end

    xit "Returns the total cost of the reservation" do

      res = Hotel::Reservation.new(today, two_days_later, room)
      num_nights = (two_days_later - today).to_i
      expected_cost = num_nights * room.rate
      res.total_cost.must_equal expected_cost

      new_rate = 300
      room.rate = new_rate
      # binding.pry
      res.total_cost.must_equal (num_nights * new_rate)

    end

  end

  # describe "#self.find" do
  #   before do
  #     date_to_check = Date.new(2017,9,5)
  #   end
  #
  #   it "Returns a list of Reservations for a given date" do
  #
  #   end
  # end
end
