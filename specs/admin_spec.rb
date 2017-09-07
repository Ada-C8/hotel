require_relative 'spec_helper.rb'

describe 'Admin class' do
  before do
    @administrator = Hotel::Admin.new
  end

  describe 'Initialize' do
    it "Can be create" do
      @administrator.must_be_instance_of Hotel::Admin
    end

    it "Create list of Reservation" do
      @administrator.list_reservations.must_equal []
    end
  end

  describe "Creates a new reservation" do
    before do
      @day1 = Date.new(2017, 8, 29)
      @day2 = Date.new(2017, 9, 3)
    end

    it "Creates an array of reservation" do
      @administrator.add_reservation(@day1,@day2).must_be_instance_of Array
    end

    it "Each element in the array is a Reservation" do
      @administrator.add_reservation(@day1,@day2)[0].must_be_instance_of Hotel::Reservation
    end
  end

  describe "reservations_per_day" do
    
  end
end#describe class
