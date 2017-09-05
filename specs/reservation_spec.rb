require_relative 'spec_helper'

describe 'Reservation' do
  before do
    @reservation = Hotel::Reservation.new('2017-09-05', '2017-09-07')
  end

  describe '#initialize' do
    it 'can be instantiated' do
      @reservation.must_be_kind_of Hotel::Reservation
    end


  end
end
