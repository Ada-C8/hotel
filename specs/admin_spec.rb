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

      @reservation_1 = @tim_curry.reserve([2019, 11, 15], [2019, 11, 18], 4, "Kevin McCallister", "New York")

      @reservation_2 = @tim_curry.reserve([2019, 11, 15], [2019, 11, 18], 8, "Sticky Bandits", "New York")

    end

    it "create an instance of Hotel::Reservation" do
      @tim_curry.reservations_list.each do |reservation|
        reservation.must_be_instance_of Hotel::Reservation
      end
    end#end instance of Hotel::Reservation

    it "puts the correct number of reservations in the @reservations_list" do
      @tim_curry.reservations_list.length.must_equal 2
    end

    it "can get the correct price" do
      @tim_curry.reservations_list[0].price.must_equal 600
    end

    it "will raise error if you try to reserve taken room" do
      proc{@tim_curry.reserve([2019, 11, 15], [2019, 11, 18], 8, "Beetlejuice, Beetlejuice, Beetlejuice!", "New York")}.must_raise ArgumentError
    end

  end#end "reserve" describe

  describe "checking for rooms_available?" do
    before do
      @tim_curry = Hotel::Admin.new

      @reservation_1 = @tim_curry.reserve([2019, 11, 15], [2019, 11, 18], 4, "Kevin McCallister", "New York")

      @reservation_2 = @tim_curry.reserve([2019, 11, 15], [2019, 11, 18], 8, "Sticky Bandits", "New York")
    end

    it "should be able to check for vacancies" do
      vacancies = @tim_curry.rooms_available?([2019, 11, 15], [2019, 11, 18])

      vacancies.length.must_equal 18
      vacancies.must_equal [1, 2, 3, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    end

  end#describe rooms available
  describe "reservations_by_date" do
    before do
      @tim_curry = Hotel::Admin.new

      @reservation_1 = @tim_curry.reserve([2019, 11, 15], [2019, 11, 18], 4, "Kevin McCallister", "New York")

      @reservation_2 = @tim_curry.reserve([2019, 11, 15], [2019, 11, 18], 8, "Sticky Bandits", "New York")
    end

    it "should be able to return empty array when no reservations" do
      reservations = @tim_curry.reservations_by_date([2019, 11, 30])
      reservations.must_be_instance_of Array
      reservations[0].must_be_nil
    end
    it "should return all reservations for a date" do
      reservations = @tim_curry.reservations_by_date([2019, 11, 16])
      reservations.length.must_equal 2
      reservations[0].must_equal @tim_curry.reservations_list[0]
    end
  end

  describe "reservations_by_name" do
    before do
    @tim_curry = Hotel::Admin.new

    @reservation_1 = @tim_curry.reserve([2019, 11, 15], [2019, 11, 18], 4, "Kevin McCallister", "New York")

    @reservation_2 = @tim_curry.reserve([2019, 11, 15], [2019, 11, 18], 8, "Sticky Bandits", "New York")
  end

    it "can find reservations by name" do
      found_name = @tim_curry.reservations_by_name("Sticky Bandits")
      found_name.wont_be_nil
      found_name[0].name.must_equal "Sticky Bandits"
    end

    it "can find multiple entries with the same name" do
      reservation_3 = @tim_curry.reserve([2019, 11, 22], [2019, 11, 30], 19, "Sticky Bandits",  "New York")

      found_name = @tim_curry.reservations_by_name("Sticky Bandits")

      found_name.length.must_equal 2
      found_name[0].name.must_equal "Sticky Bandits"
      found_name[1].name.must_equal "Sticky Bandits"

    end
  end


end #end class Admin Describe
