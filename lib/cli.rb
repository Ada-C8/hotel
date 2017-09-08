module Hotel
  class Cli

    attr_reader :hotel

    def initialize
      @hotel = Hotel.new
    end

    def display_user_menu
      puts "\nWhat would you like to do?\n
      A. Book a room
      B. Reserve a block of rooms
      C. View reservations
      D. View available rooms
      E. View available rooms in a block
      F. Change the price of a room
      G. View all rooms in the hotel\n"
    end

    def get_option

    end

  end
end # end of hotel module
# 
# interface = Hotel::Cli.new
