require_relative 'room_block'
require_relative 'reservation'
require_relative 'room'
require_relative 'hotel'
require_relative 'NoAvailableRoomError'
require_relative 'cli'

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

    choice = gets.chomp

    quit = true if choice == "X"

    case choice
    when "1"

      print "Client's name: "
      client_name = gets.chomp

      print "Arrival date (mm/dd/yyyy): "
      arrival = gets.chomp
      arrival_array = arrival.split("/")
      # arrival_date = arrival_array[2] + ", " + arrival_array[0] + ", " + arrival_array[1]

      print "Departure date (mm/dd/yyyy): "
      departure = gets.chomp
      departure_array = departure.split("/")
      # departure_date = departure_array[2] + ", " + departure_array[0] + ", " + departure_array[1]

      print "Number of rooms: "
      num_rooms = gets.chomp

      puts "Confirm reservation of #{num_rooms} room(s) for #{client_name} from #{arrival} to #{departure}? Y/N"
      confirm = gets.chomp

      until confirm == "Y" || confirm == "N"
        puts "Please answer Y or N."
        confirm = gets.chomp
      end

      if confirm == "Y"
        hotel.make_reservation(client_name, arrival_array[2].to_i, arrival_array[0].to_i, arrival_array[1].to_i, departure_array[2].to_i, departure_array[0].to_i, departure_array[1].to_i, num_rooms)
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
      arrival_array = arrival.split("/")
      # arrival_date = arrival_array[2] + ", " + arrival_array[0] + ", " + arrival_array[1]

      print "Departure date (mm/dd/yyyy): "
      departure = gets.chomp
      departure_array = departure.split("/")
      # departure_date = departure_array[2] + ", " + departure_array[0] + ", " + departure_array[1]

      print "Number of rooms: "
      num_rooms = gets.chomp

      print "The current cost per room is $200. Do you want to enter a special rate? Y/N"
      rate = 160.00
      answer = gets.chomp
      if answer == "Y"
        print "Enter a new rate: "
        rate = gets.chomp.to_f
      end

      puts "Confirm room block of #{num_rooms} rooms for #{client_name} from #{arrival} to #{departure}? Y/N"
      confirm = gets.chomp

      until confirm == "Y" || confirm == "N"
        puts "Please answer Y or N."
        confirm = gets.chomp
      end

      if confirm == "Y"
        hotel.create_block(client_name, arrival_array[2].to_i, arrival_array[0].to_i, arrival_array[1].to_i, departure_array[2].to_i, departure_array[0].to_i, departure_array[1].to_i, num_rooms)
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
      arrival_array = arrival.split("/")

      print "To (mm/dd/yyyy): "
      departure = gets.chomp
      departure_array = departure.split("/")

      avaibility = hotel.available_at_period(arrival_array[2].to_i, arrival_array[0].to_i, arrival_array[1].to_i, departure_array[2].to_i, departure_array[0].to_i, departure_array[1].to_i)

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
      if reservations == nil
        puts "No reservations."
      else
        puts "Here are all the reservations:"
        reservations.each do |res|
          res.summary
          # puts "\n#{res.client}:"
          # puts "- Arrival date: #{res.arrival_date}"
          # puts "- Departure date: #{res.departure_date}"
          # puts "- Stay length: #{res.stay_length}"
          # puts "- Number of rooms #{res.number_of_rooms}"
          # puts "- Type: #{res.type}"
          # puts "- Total cost #{res.total}"
        end
      end

    end
  end










end
