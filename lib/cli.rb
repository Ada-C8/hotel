require_relative 'hotel'
require_relative 'pricing'
require 'terminal-table'
require 'chronic'
require 'pry'

module Hotel
  class Cli

    attr_reader :hotel

    def initialize
      @hotel = Hotel.new
    end

    def begin
      while true
        run_program
      end
    end

    def run_program
      begin
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
      rescue
        puts "I'm sorry! Something went wrong! Please try again"
        return true
      end
    end

    def display_user_menu
      puts "\nMenu Options:\n
      A. Book a room
      B. Book a room from a block
      C. Reserve a block of rooms
      D. View reservations (and costs) by date
      E. View all reservations
      F. View available rooms
      G. View available rooms in a block
      H. Change the cost of a room
      I. View all rooms in the hotel\n
      X. Exit the program"
    end

    def get_input
      input = gets.chomp
      return input
    end

    def get_menu_option
      choice = nil
      until choice =~ (/^[A-Ia-i]|[Xx]$/)
        print "\nPlease choose an option: "
        choice = get_input
      end
      return choice.upcase
    end

    ### Write in option of no room preference
    # choice A
    def reserve_room
      check_in = get_date_for("check in", Date.today)

      check_out = get_date_for("check out", check_in + 1)

      print "Guest Name: "
      guest = get_input

      print "Preferred Room (Type N for no preference): "
      room_number = get_room

      res = hotel.make_reservation(guest, check_in, check_out, room_number)

      show_table_of_reservations([res.last])
    end

    # choice B
    def reserve_room_from_block
      block = get_block

      print "Guest Name: "
      guest = get_input

      res = hotel.make_reservation_from_block(guest, block.id)

      show_table_of_reservations([res.last])
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
      reservations = hotel.get_res_by_date(date)

      show_table_of_reservations(reservations)
    end

    # choice E
    def view_all_reservations
      show_table_of_reservations(hotel.reservations)
    end

    # choice F
    def view_available_rooms

      begin_date = get_date_for("begin", Date.today)

      end_date = get_date_for("end", begin_date + 1)

      available_rooms = hotel.get_available_rooms(begin_date, end_date)

      show_table_of_rooms(available_rooms)
    end

    # choice G
    def view_available_rooms_in_block
      block = get_block

      puts "Rooms still available for block ID:#{block.id} :"

      rooms_available_in_block = hotel.get_available_rooms_from_block(block)

      show_table_of_rooms(rooms_available_in_block)

    end

    # choice H
    def change_room_cost
      room = get_room
      print "New Cost: "
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
        print "How many rooms would you like to reserve? (max 5)"
        num_rooms = get_input
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
        input = get_input

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
        block_id = get_value

        hotel.blocks.each do |block|
          if block.id == block_id.to_i
            return block
          end
        end
        puts "I'm sorry, that ID doesn't exist."
      end
    end

    def get_value
      value = gets.chomp
      until value =~ (/\d/)
        puts "Invalid. Please enter a number."
        value = get_input
      end
      return value.to_i
    end

    def get_room
      print "\n\tRoom Number: "
      room_number = get_input
      until room_number =~ (/^([1-9]|1[0-9]|20|[Nn])$/)
        puts "Invalid Room Number."
        print "Room Number: "
        room_number = get_input
      end

      if room_number == "N" || room_number == "n"
        return nil
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
      return table
    end

    def show_table_of_reservations(reservations)
      table = Terminal::Table.new do |t|
        t << ["Guest Name", "Check_in", "Check_out", "Room", "Total Cost", "Block ID" ]
        reservations.each do |res|
          res.block_id ? block_id = res.block_id : block_id = nil

          t << :separator
          t << [res.guest, res.check_in, res.check_out, res.room.number, Pricing.calc_cost(res), block_id]
        end
      end
      puts table
      return table
    end
  end
end # end of hotel module


#
interface = Hotel::Cli.new
interface.begin
