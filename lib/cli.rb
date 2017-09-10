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
      beginning_date = get_date_for(
      "begin")

      end_date = get_date_for("end")

      available_rooms = hotel.get_available_rooms(beginning_date, end_date)

      show_table_of_rooms(available_rooms)
    end


    ####### COME BACK TO THIS TO SEE IF IT WORKS ##########
    def view_available_rooms_in_block
      block = get_block

      puts "Rooms still available for block ID:#{block.id} :"

      rooms_available_in_block = hotel.get_available_rooms_from_block(bblock)

      show_table_of_rooms(rooms_available_in_block)

    end

    def change_room_cost
      room = get_room
      new_cost = get_value

      room.cost_per_night = new_cost

      puts "\nRoom #{room.number} has been changed to $#{room.cost_per_night} per night."

      view_rooms
    end

    def view_rooms
      puts "\nHere is a current list of the rooms and their prices: "

      show_table_of_rooms(hotel.rooms)
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

    def get_date_for(action)
      puts "What date would you like to #{action}?"


    end

    def get_menu_option
      choice = nil
      until choice =~ (/^[A-Ga-g]$/)
        print "\nPlease choose an option: "
        choice = $stdin.gets.chomp
      end
      return choice
    end

    def get_block
      while true
        print "Block ID: "
        block_id = gets.chomp

        hotel.blocks.each do |block|
          if block.id = block_id
            return block
          end
        end
        puts "I'm sorry, that ID doesn't exit."
      end
    end

    ########## WRITE TESTS ###########
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

    ########## WRITE TESTS ##############
    def get_room
      print "\n\tRoom Number: "
      room_number = gets.chomp
      until room_number =~ (/^([1-9]|1[0-9]|20)$/)
        puts "Invalid Room Number."
        print "Room Number: "
        room_number = gets.chomp
      end

      hotel.rooms.each do |room|
        if room.number == room_number.to_i
          return room
        end
      end
      raise StandardError.new "No room found"
    end

    def show_table_of_rooms(rooms_arry)
      table = Terminal::Table.new do |t|
        t << ["Room", "Cost per night"]
        rooms.each do |room|
          t << :separator
          t << [room.number, room.cost_per_night]
        end
      end
      puts table
    end
  end
end # end of hotel module
#
interface = Hotel::Cli.new
interface.begin
