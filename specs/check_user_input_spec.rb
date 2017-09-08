require_relative 'spec_helper'

describe "CheckUserInput module" do

  it "Raises an InvalidRoomError if input for room is not an Integer between 1-20" do

    proc { BookingSystem::CheckUserInput.check_user_input(0) }.must_raise BookingSystem::Reservation::InvalidRoomError

    proc { BookingSystem::CheckUserInput.check_user_input(21) }.must_raise BookingSystem::Reservation::InvalidRoomError

    proc { BookingSystem::CheckUserInput.check_user_input("one") }.must_raise BookingSystem::Reservation::InvalidRoomError

  end

end
