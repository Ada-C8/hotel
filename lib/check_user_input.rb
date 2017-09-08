module BookingSystem
  module CheckUserInput

    def self.integer(user_input)
      unless user_input.class == Integer
        raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{user_input})")
      end

    def self.between_1_21(user_input)
      unless user_input > 0 && user_input < 21
        raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{user_input})")
      end
    end

    def self.between_1_5(user_input)
      unless user_input > 0 && user_input < 6
        raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-5 (given: #{user_input})")
      end
    end

    end

  end
end
