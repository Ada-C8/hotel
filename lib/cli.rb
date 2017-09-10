require_relative 'hotel'
require 'terminal-table'

module Hotel
  class Cli

    attr_reader :hotel

    def initialize
      @hotel = Hotel.new
    end

    def begin
      display_user_menu
      choice = get_menu_option

      case choice
      when "A"
        reserve_room
      when "B"
        make_block_of_rooms
      when "C"
        view_reservations
      when "D"
        view_available_rooms
      when "E"
        view_available_rooms_in_block
      when "F"
        change_room_cost
      when "G"
        view_rooms
      else
        raise ArgumentError.new "not a valid choice"
      end
    end

    def reserve_room
    end

    def make_block_of_rooms
    end

    def view_reservations
    end

    def view_available_rooms
    end

    def view_available_rooms_in_block

    end

    #############!##!!###!!!! DOESN'T WORK!!!!!!!!!!

    def change_room_cost
      room_number = get_room_number
      new_cost = get_value


      hotel.rooms.each do |room|
        if room.number == room_number
          room.cost_per_night = new_cost
        end
      end

      view_rooms
    end

    def view_rooms
      puts "The hotel has the following rooms: "
      table = Terminal::Table.new do |t|
        t << ["Room", "Cost per night"]
        hotel.rooms.each do |room|
          t << :separator
          t << [room.number, room.cost_per_night]
        end
      end
      puts table
    end

    def display_user_menu
      puts "\nMenu Options:\n
      A. Book a room
      B. Reserve a block of rooms
      C. View reservations
      D. View available rooms
      E. View available rooms in a block
      F. Change the cost of a room
      G. View all rooms in the hotel\n"
    end

    def get_menu_option
      choice = nil
      until choice =~ (/^[A-Ga-g]$/)
        print "\nPlease choose an option: "
        choice = $stdin.gets.chomp
      end
      return choice
    end

    def get_value
      print "\n\tNew Cost: "
      value = gets.chomp
      until value =~ (/\d/)
        puts "Invalid Cost."
        print "New Cost: "
        value = gets.chomp
      end
      return value.to_i
    end

    def get_room_number
      print "\n\tRoom Number: "
      room_number = gets.chomp
      until room_number =~ (/^([1-9]|1[0123456789]|20)$/)
        puts "Invalid Room Number."
        print "Room Number: "
        room_number = gets.chomp
      end
      return room_number.to_i
    end

  end
end # end of hotel module
#
interface = Hotel::Cli.new
interface.begin
