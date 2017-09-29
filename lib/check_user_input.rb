module BookingSystem
  module CheckUserInput

    def self.integer(user_input)
      unless user_input.class == Integer
        raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{user_input})")
      end
    end

    def self.between_1_20(user_input)
      unless user_input > 0 && user_input < 21
        raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20. (Given: #{user_input})")
      end
    end

    def self.between_1_5(user_input)
      unless user_input > 0 && user_input < 6
        raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-5. (Given: #{user_input})")
      end
    end

    def self.price(user_input)
      unless user_input.class == Integer
        raise BookingSystem::Reservation::InvalidPriceError.new("Invalid price error. Room price must be a whole number (100, 150, 250). (Given: #{user_input})")
      end

      unless user_input > 50
        raise BookingSystem::Reservation::InvalidPriceError.new("Invalid price error. Room price must be a whole number greater than 50 (100, 150, 250). (Given: #{user_input})")
      end
    end

  end
end
