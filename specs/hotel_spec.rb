require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/hotel'
require_relative './spec_helper.rb'

describe "Hotel" do
  describe "initialize hotel" do

  it "can initialize hotel" do
    new_hotel = Hotels::Hotel.new
    new_hotel.must_be_instance_of Hotels::Hotel
    new_hotel.reservations.must_be_kind_of Array
  end
end
end
