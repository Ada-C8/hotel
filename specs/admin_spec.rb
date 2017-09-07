require_relative '../lib/admin'
require_relative 'spec_helper'
require 'pry'

describe "class Admin" do
  describe "initialize" do
    it "initializes all instance variables" do
      admin_1 = Hotel::Admin.new
      admin_1.all_rooms.length.must_equal 20
      admin_1.reservations_list.must_be_instance_of Array
      admin_1.must_be_instance_of Hotel::Admin
    end
  end


  describe "reserve" do
    before do
      @tim_curry = Hotel::Admin.new

      @reservation_1 = @tim_curry.reserve([2019, 11, 15], [2019, 11, 15], 4, "Kevin McCallister", "New York")

      @reservation_2 = @tim_curry.reserve([2019, 11, 15], [2019, 11, 15], 8, "Sticky Bandits", "New York")

    end

    it "create an instance of Hotel::Reservation" do
      @tim_curry.reservations_list.each do |reservation|
        reservation.must_be_instance_of Hotel::Reservation
      end
    end#end instance of Hotel::Reservation

    it "puts the correct number of reservations in the @reservations_list" do
      @tim_curry.reservations_list.length.must_equal 2
    end

  end#end "reserve" describe

  describe "checking for rooms_available" do
    



  end


end #end class Admin Describe
