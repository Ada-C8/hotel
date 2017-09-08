require_relative 'spec_helper'

describe "CheckUserInput module" do

  describe "integer method" do

    it "Raises an InvalidRoomError if input is not an Integer" do
      proc { BookingSystem::CheckUserInput.integer("one") }.must_raise BookingSystem::Reservation::InvalidRoomError
    end

  end

  describe "between_1_20 method" do
    it "Raises an InvalidRoomError if input for room is not an Integer between 1-20" do

      proc { BookingSystem::CheckUserInput.between_1_20(0) }.must_raise BookingSystem::Reservation::InvalidRoomError

      proc { BookingSystem::CheckUserInput.between_1_20(21) }.must_raise BookingSystem::Reservation::InvalidRoomError
    end
  end

  describe "between_1_5 method" do
    it "Raises an InvalidRoomError if input for room is not an Integer between 1-5" do

      proc { BookingSystem::CheckUserInput.between_1_5(0) }.must_raise BookingSystem::Reservation::InvalidRoomError

      proc { BookingSystem::CheckUserInput.between_1_5(6) }.must_raise BookingSystem::Reservation::InvalidRoomError

    end

  end
end
