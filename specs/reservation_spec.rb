require_relative 'spec_helper'

describe "reservation" do
  before do
    @test_res = Hotel::Reservation.new(1, 20.0, [1], [5, 6])
  end # before

  describe "initialize" do

    it "will initialize an instance of the Reservation class" do
      @test_res.must_be_kind_of Hotel::Reservation
    end # it "will initialize an instance of the Reservation class" do

    it "will have reservation id as an Integer" do
      @test_res.res_id.must_be_kind_of Integer
    end # it "will have reservation id as an Integer" do

    it "will have total_cost as a flaot" do
      @test_res.total_cost.must_be_kind_of Float
    end # it "will have total_cost as a flaot" do

    it "Will have rooms as an array of integers" do
       @test_res.res_rooms.must_be_kind_of Array
    end # it "Will have rooms as an array of integers" do

    it "will have the date range as an array of (whatever the date gem makes it)" do
      @test_res.date_range.must_be_kind_of Array
    end #it "will have the date range as an array of (whatever the date gem makes it)" do

#TODO : Do I need to put argument errors if a reservation is initlized with incorrect input? Or do I not need to since other methods directly pass Reservation the input it needs to

  end # describe "initialize" do
end # describe "reservation" do
