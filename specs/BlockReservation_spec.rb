require 'date'
require 'pry'
require_relative 'spec_helper'

describe "Hotel::BlockReservation class" do
  describe "initialize" do
    it "initalizes" do
      check_in_str = "2018-10-03"
      check_out_str = "2018-10-06"
      room_id = 1
      b_res_id = 14
      discounted_rate = 5
      block_id = 42

      new_block_res = Hotel::BlockReservation.new(check_in_str, check_out_str,room_id,b_res_id,discounted_rate, block_id)

      new_block_res.must_be_instance_of Hotel::BlockReservation

    end
  end

  describe "num_nights_charged" do

    it "correctly inherits the num_nights_charged method from the Hotel::Reservation class" do
      blockres1 = Hotel::BlockReservation.new("2018-02-14", "2018-02-16",3,14,5)

      blockres1.num_nights_charged.must_equal 2
    end
  end

  describe "cost" do
    it "calculates cost with a discounted rate" do
      discounted_rate = 5
      blockres1 = Hotel::BlockReservation.new("2018-02-14", "2018-02-16",14,42,discounted_rate)
      blockres1.cost.must_equal 10

      blockres2 = Hotel::BlockReservation.new("2018-12-01", "2018-12-02",1,5,discounted_rate)

      blockres2.cost.must_equal 5
    end
  end

end
