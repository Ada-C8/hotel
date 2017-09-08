require_relative 'spec_helper'

describe "Reservable Module" do
  before do
    @hotel_california = ReservationSystem::Hotel.new
  end

  let(:day) {Date.new(2017,10,12)}
  let(:room_5) {@hotel_california.hotel[4]}

  it "Raises an error if date submitted is not a valid Date object" do
    proc {@hotel_california.valid_date?(2017)}.must_raise Reservable::DateError
    proc {@hotel_california.valid_date?('2017-06-12')}.must_raise Reservable::DateError
    proc {@hotel_california.valid_date?(-3)}.must_raise Reservable::DateError
    proc {@hotel_california.valid_date?([123.40, "a"])}.must_raise Reservable::DateError
    proc {@hotel_california.valid_date?(:pie)}.must_raise Reservable::DateError
    proc {@hotel_california.valid_date?({:pie => 14})}.must_raise Reservable::DateError
    proc {@hotel_california.valid_date?(room_5)}.must_raise Reservable::DateError

  end #valid_date error

  it "Raises an error if nights is not a positive integer" do
    proc {@hotel_california.positive_integer?(0)}.must_raise Reservable::PositiveIntegerError
    proc {@hotel_california.positive_integer?(-1)}.must_raise Reservable::PositiveIntegerError
    proc {@hotel_california.positive_integer?(0.24)}.must_raise Reservable::PositiveIntegerError
    proc {@hotel_california.positive_integer?("alpha")}.must_raise Reservable::PositiveIntegerError
    proc {@hotel_california.positive_integer?({"yummy" => "foods"})}.must_raise Reservable::PositiveIntegerError
    proc {@hotel_california.positive_integer?([4, 1])}.must_raise Reservable::PositiveIntegerError
    proc {@hotel_california.positive_integer?(:pie)}.must_raise Reservable::PositiveIntegerError
    proc {@hotel_california.positive_integer?(day)}.must_raise Reservable::PositiveIntegerError

  end #valid number error

  #TODO ?? change tests to their respective methods Reservation.new and search_reservations_by_date -- do in reservable tests primarily.
end # Reservable module
