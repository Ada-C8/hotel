module BookingSystem
  module CheckUserInput

    def self.check_user_input(user_input)
      unless user_input.class == Integer
        raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{user_input})")
      end

      unless user_input > 0 && user_input < 21
        raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{user_input})")
      end
    end

  end
end
