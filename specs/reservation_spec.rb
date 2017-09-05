require 'pry'
require_relative 'spec_helper'

describe "Reservation class" do

  describe "initialize" do
    it "can instantiate a reservation class" do
      Hotel::Reservation.new.must_be_kind_of Hotel::Reservation
    end
  end






end #Reservation class
