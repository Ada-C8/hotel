require_relative '../lib/dates'
require_relative 'spec_helper'

describe "NIGHTS" do
  describe "#INITIALIZE" do
    it "initialize a date range" do
      Nights.new("January 4, 2018", "January 12, 2018")
    end
  end
end
