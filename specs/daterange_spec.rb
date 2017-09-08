require_relative 'spec_helper'
require_relative '../lib/hotel'

describe "Hotel" do
  describe "initialize" do
    it "checks initialize" do
      a = Hotel.new()
      a.test.must_equal []
    end 
  end
end
