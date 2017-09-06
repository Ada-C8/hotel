require_relative 'spec_helper'
require 'date'

describe "DateRange class" do

  before do
    check_in = Date.new(2017,9,9)
    check_out = Date.new(2017,9,11)
    @test_ob = BookingSystem::DateRange.new(check_in, check_out)
  end

  describe "intialize method" do

    it "Can be initialized" do
      @test_ob.must_be_instance_of BookingSystem::DateRange
    end

    it "Has an instance variable @check_in that is an instance of Date" do
      @test_ob.check_in.must_be_instance_of Date
    end

    it "Has an instance variable @check_out that is an instance of Date" do
      @test_ob.check_out.must_be_instance_of Date
    end
  end


end
