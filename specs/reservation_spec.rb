require_relative 'spec_helper'
require_relative '../lib/reservation'

describe 'Reservation' do
  before do

    @room = 2
    @checkin = Date.new(2017, 5, 5)
    @checkout = @checkin + 3
    @price = 200
    @test_rez = Property::Reservation.new(@room, @checkin, @checkout, @price)
  end

  it " responds to attr reader" do
    @test_rez.must_respond_to :room
    @test_rez.must_respond_to :price
  end

  it "is a subclass of Range" do
    @test_rez.must_be_kind_of Property::Range
  end

  it "calculates correct total" do
    @test_rez.total_price.must_equal 600
  end

end
