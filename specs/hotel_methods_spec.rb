require_relative 'spec_helper.rb'
require_relative '../lib/hotel_methods'


  describe "date_ify" do
    it "turns arguments into date objects" do
      Hotel.date_ify("3-1-2017").must_be_kind_of Date
    end
  end
