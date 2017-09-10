require_relative 'hotel'
require 'terminal-table'
require 'chronic'

module Hotel
  class Cli

    attr_reader :hotel

    def initialize
      @hotel = Hotel.new
    end

    def begin
      while true
        display_user_menu
        choice = get_menu_option

        case choice
        when "A"
          reserve_room
        when "B"
          reserve_room_from_block
        when "C"
          make_block_of_rooms
        when "D"
          view_reservations
        when "E"
          view_all_reservations
        when "F"
          view_available_rooms
        when "G"
          view_available_rooms_in_block
        when "H"
          change_room_cost
        when "I"
          view_rooms
        when "X"
          abort("Thank you! Have a nice day!")
        else
          raise ArgumentError.new "not a valid choice"
        end

      end
    end

    def display_user_menu
      puts "\nMenu Options:\n
      A. Book a room
      B. Book a room from a block
      C. Reserve a block of rooms
      D. View reservations by date
      E. View all reservations
      F. View available rooms
      G. View available rooms in a block
      H. Change the cost of a room
      I. View all rooms in the hotel\n
      X. Exit the program"
    end

    def get_menu_option
      choice = nil
      until choice =~ (/^[A-Ia-i]|[Xx]$/)
        print "\nPlease choose an option: "
        choice = $stdin.gets.chomp
      end
      return choice.upcase
    end

    ### Write in option of no room preference
    # choice A
    def reserve_room

      check_in= get_date_for("check in", Date.today)

      check_out = get_date_for("check out", check_in + 1)

      print "Guest Name: "
      guest = gets.chomp

      print "Preferred Room: "
      room = get_room

      hotel.make_reservation(guest, check_in, check_out, room.number)
    end

    # choice B
    def reserve_room_from_block
      block = get_block

      print "Guest Name: "
      guest = gets.chomp

      hotel.make_reservation_from_block(guest, block.id)
    end

    # choice C
    def make_block_of_rooms
      check_in = get_date_for("check in", Date.today)

      check_out = get_date_for("check out", check_in + 1)

      num_rooms = get_num_rooms

      block = hotel.make_block(check_in, check_out, num_rooms)

      puts "Here are the rooms reserved for block ID: #{block.id}"

      show_table_of_rooms(block.rooms_in_block)
    end

    # choice D
    def view_reservations
      date = get_date_for("see reservations for")
      hotel.get_res_by_date(date)


      show_table_of_rooms(block.rooms_in_block)
    end

    # choice E
    def view_all_reservations
      show_table_of_reservations(hotel.reservations)
    end

    # choice F
    def view_available_rooms

      begin_date = get_date_for("begin", Date.today)

      end_date = get_date_for("end", begin_date + 1)

      available_rooms = hotel.get_available_rooms(beginning_date, end_date)

      show_table_of_rooms(available_rooms)
    end

    # choice G
    def view_available_rooms_in_block
      block = get_block

      puts "Rooms still available for block ID:#{block.id} :"

      rooms_available_in_block = hotel.get_available_rooms_from_block(bblock)

      show_table_of_rooms(rooms_available_in_block)

    end

    # choice H
    def change_room_cost
      room = get_room
      new_cost = get_value

      room.cost_per_night = new_cost

      puts "\nRoom #{room.number} has been changed to $#{room.cost_per_night} per night."

      view_rooms
    end

    # choce I
    def view_rooms
      puts "\nHere is a current list of the rooms and their prices: "

      show_table_of_rooms(hotel.rooms)
    end

    def get_num_rooms
      num_rooms = nil
      until num_rooms =~ (/[1-5]/)
        print "How many rooms would you like to reserve? "
        num_rooms = gets.chomp
      end
      return num_rooms.to_i
    end

    def get_date_for(action, must_be_after_date = nil)
      date = nil

      while date == nil
        date = get_date(action, must_be_after_date)
      end

      return date.to_date
    end

    def get_date(action, must_be_after_date)
      begin
        print "What date would you like to #{action}?  "
        input = gets.chomp

        date = Chronic.parse(input).to_date

        if (must_be_after_date != nil) && (date < must_be_after_date)
          raise StandardError.new "Invalid Date"
        end
      rescue
        puts "Invalid date"
        date = nil
      end
      return date
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
        rooms_arry.each do |room|
          t << :separator
          t << [room.number, room.cost_per_night]
        end
      end
      puts table
    end

    def show_table_of_reservations(reservations)
      table = Terminal::Table.new do |t|
        t << ["Guest Name", "Check_in", "Check_out", "Room", "Block ID" ]
        reservations.each do |res|
          res.block_id ? block_id = res.block_id : block_id = ""

          t << :separator
          t << [res.guest, res.check_in, res.check_out, res.room.number, block_id]
        end
      end
      puts table
    end
  end
end # end of hotel module



interface = Hotel::Cli.new
interface.begin
