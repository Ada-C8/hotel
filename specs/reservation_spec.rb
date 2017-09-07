require_relative 'spec_helper'

describe 'Reservation' do
  before do
    @checkin = Date.new(2017, 10, 31)
    @checkout = Date.new(2017, 11, 4)
    @reservation = Hotels::Reservation.new(@checkin, @checkout)
  end # ------------------------- before block

  describe '#initialize' do
    it 'Can be initialized' do
      @reservation.must_be_instance_of Hotels::Reservation
    end
    it 'Has an ID' do
      @reservation.id.must_be_kind_of Integer
    end
    it 'Must contain at least one Date' do
      @reservation.dates.length.must_be :>=, 1
      @reservation.dates[0].must_be_instance_of Date
    end
    it 'Creates a new Reservation with a single date parameter' do
      Hotels::Reservation.new(@checkin).must_be_kind_of Hotels::Reservation
    end
    # W1-E1 Raise an error when an invalid date range is provided
    it 'Raises error the check-out date is earlier than the check-in date' do
      checkin = Date.new(2017, 10, 31)
      checkout = Date.new(2016, 11, 4)
      proc {
        Hotels::Reservation.new(checkin, checkout)
      } .must_raise ArgumentError
    end
    it 'Raises error if the check-in date is in the past' do
      checkin = Date.new(2016, 11, 4)
      proc {
        Hotels::Reservation.new(checkin)
      } .must_raise ArgumentError
    end
    # W1-E1 Raise an error when an invalid date range is provided
    it 'Raises error if check-in and check-out dates are in the past' do
      checkin = Date.new(2016, 10, 31)
      checkout = Date.new(2016, 11, 4)
      proc {
        Hotels::Reservation.new(checkin, checkout)
      } .must_raise ArgumentError
    end
  end # ------------------------- describe #initialize block
end
