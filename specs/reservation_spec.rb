require_relative 'spec_helper.rb'

describe 'Registration class' do
  describe 'initialize'do
    it 'Can be initialize' do
      checkin = Date.new(2017,9,10)
      checkout = Date.new(2017,9,13)
      Hotel::Reservation.new(checkin, checkout).must_be_instance_of Hotel::Reservation
    end

    it "doesn't initialize wrong dates" do
      checkin = Date.new(2017,9,10)
      checkout = Date.new(2017,9,13)
      proc{Hotel::Reservation.new(checkin, checkin)}.must_raise ArgumentError
    end
  end

  describe 'total price' do
    it 'calcualate the total price' do
      checkin = Date.new(2017,9,10)
      checkout = Date.new(2017,9,13)
      newreservation = Hotel::Reservation.new(checkin, checkout)
      newreservation.totalcost.must_equal 600
    end

    
  end
end#describe Registratioin class
