require_relative 'spec_helper'

describe "Guest" do
  before do
    @guest_test = BookingSystem::Guest.new("Jane", "Doe")
  end

  describe "initialize" do
    it "can create an instance of Guess class" do
      @guest_test.class.must_equal BookingSystem::Guest
    end

    it "can access a guest's first name and last name" do
      @guest_test.first_name.must_equal "Jane"
      @guest_test.last_name.must_equal "Doe"
    end

    it "ensures first name and last name are strings" do
      proc { BookingSystem::Guest.new([], "Doe") }.must_raise ArgumentError
      proc { BookingSystem::Guest.new("Jane", 2) }.must_raise ArgumentError
    end

  end

end#_of_"Guest"
