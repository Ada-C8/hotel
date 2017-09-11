require_relative 'room_block'
require_relative 'reservation'
require_relative 'room'
require_relative 'hotel'
require_relative 'NoAvailableRoomError'
require_relative 'cli_methods'

module Hotel

  puts "\n\nWelcome to the Super Hotel's administrator app!"

  hotel = Hotel.new(20)

  quit = false

  until quit == true

    puts "\nWhat would you like to do:"
    puts "Book a room > 1"
    puts "Print a reservation > 2"
    puts "Book a room block > 3"
    puts "Manage a room block > 4"
    puts "See all rooms > 5"
    puts "See available rooms at date > 6"
    puts "See all reservations > 7"
    puts "Quit > X"

    print "\nChoice: "

    choice = gets.chomp
    legal_choices = ["1","2","3","4","5","6","7","X"]
    until legal_choices.include? choice
      print "\nPlease enter a valid choice: "
      choice = gets.chomp
    end

    case choice
    when "1"

      print "\nClient's name: "
      client_name = gets.chomp

      print "Arrival date (mm/dd/yyyy): "
      arrival = gets.chomp

      print "Departure date (mm/dd/yyyy): "
      departure = gets.chomp

      print "Number of rooms: "
      num_rooms = gets.chomp

    puts "Confirm reservation of #{num_rooms} room(s) for #{client_name} from #{arrival} to #{departure}? Y/N"

    answer = confirm_yes_no

    if answer == "Y" || answer == "YES"
      hotel.make_reservation(client_name, arrival, departure, num_rooms)
      puts "Reservation confirmed. The total is $#{hotel.find_reservation(client_name).total}."
    else
      puts "Reservation cancelled."
    end

    when "2"
      print "Name on the reservation: "
      client_name = gets.chomp
      reservation = hotel.find_reservation(client_name)
      if reservation == nil
        puts "No reservation found for #{client_name}"
      else
        puts reservation.summary
      end
    when "3"
      print "Client's name: "
      client_name = gets.chomp

      print "Arrival date (mm/dd/yyyy): "
      arrival = gets.chomp

      print "Departure date (mm/dd/yyyy): "
      departure = gets.chomp

      print "Number of rooms: "
      num_rooms = gets.chomp

      print "The current cost per room is $190. Do you want to enter a special rate? Y/N"
      answer = confirm_yes_no

      rate = 190.00

      if answer == "Y" || answer == "YES"
        print "\nEnter a new rate: "
        rate = gets.chomp.to_f
      end

      puts "Confirm room block of #{num_rooms} rooms for #{client_name} from #{arrival} to #{departure}? Y/N"
      answer = confirm_yes_no

      if answer == "Y" || answer == "YES"
        hotel.create_block(client_name, arrival, departure, num_rooms)
        block = hotel.find_block(client_name)
        block.room_price = rate
        puts "Room block confirmed. The total is $#{block.total}."
      else
        puts "Reservation cancelled."
      end
    when "4"
      print "Name on the room block reservation: "
      client_name = gets.chomp
      room_block = hotel.find_block(client_name)
      if room_block == nil
        puts "No reservation found for #{client_name}"
      else
        puts "What do you want to do?"
        puts "See number of available rooms > 1"
        puts "Reserve a room > 2"
        choice = gets.chomp
        case choice
        when "1"
          puts "There are #{room_block.available} rooms left in the block."
        when "2"
          puts "There are #{room_block.available} rooms left in the block. How many would you like to book?"
          num_room = gets.chomp.to_i
          room_block.reserve(num_room)
        end
      end
    when "5"
      puts "Here are all the room in the hotel:"
      hotel.list_of_rooms.each do |room|
        print "\n- Room #{room.number}: "
          if room.booked.empty?
            print "not booked"
          else
            puts "\nbooked: "
            room.booked.each do |hash|
              puts "from #{hash["arrival"]} to #{hash["departure"]}."
            end
          end
      end
    when "6"
      print "From (mm/dd/yyyy): "
      arrival = gets.chomp

      print "To (mm/dd/yyyy): "
      departure = gets.chomp

      avaibility = hotel.available_at_period(arrival, departure)

      if avaibility == nil
        puts "No availibility at these dates."
      else
        puts "There are #{avaibility.length} avalaible rooms at these dates:"
        avaibility.each do |room|
          puts "- Room #{room.number}"
        end
      end
    when "7"
      reservations = hotel.reservations
      if reservations == []
        puts "No reservations."
      else
        puts "Here are all the reservations:"
        reservations.each do |res|
          res.summary
        end
      end
    when "X"
      quit = true
    end
  end
end
