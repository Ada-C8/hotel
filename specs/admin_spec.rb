require_relative 'spec_helper.rb'
require 'pry'

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
    before do
      @date1 = Date.new(2018,01,25)
      @date2 = Date.new(2018,02,22)
      @date3 = Date.new(2018,01,31)
      @date4 = Date.new(2018,02,05)
      @date5 = Date.new(2018,01,29)
      @administrator = Hotel::Admin.new
      @administrator.add_reservation(@date1, @date3)
      @administrator.add_reservation(@date1, @date4)

      #terminar de hacer las reservaciones para los test

    end

    it 'Returns an array ' do
     @administrator.reservations_per_day(@date1).must_be_instance_of Array
    end

    it 'Returns an array of reservations instances' do
      @administrator.reservations_per_day(@date1)[0].must_be_instance_of Hotel::Reservation
    end

    it 'Returns all the reservations per day, when is not empty' do
      @administrator.reservations_per_day(@date1).length.must_equal 2
    end

    it 'Returns empty array if that day there is no reservations' do
      @administrator.reservations_per_day(@date2).must_equal []
    end


  end
end#describe class
