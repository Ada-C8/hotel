
=begin
options:
- view a list of rooms
- reserve a room
- view total cost for a reservation
- view a list of reservations for a date
- view available rooms for a date
- create a block of rooms
- check availability
- reserve a block room


- catch invalid date
- catch unavailable room
- catch room number error
=end
require 'artii'
require 'pry'
require_relative './lib/hotel-room.rb'
require_relative './lib/hotel-reservation.rb'
# User interface for hotel
def menu
  menu = <<OK
1. Find an available room
2. Reserve a room
3. View a list of reservations
4. Create a block of rooms
5. Check block rooms availability
6. Reserve a block room
7. View a list of rooms
OK
  return menu
end

def print_rooms(hotel)
  print "rooms: "
  (hotel.length - 1).times do |i|
    print "#{hotel[i].number}, "
  end
  print "#{hotel[-1].number}\n"
end
def get_date(position)
  print "What is your #{position} date: "
  user = gets.chomp
  begin
    user_date = Date.parse(user)
  rescue ArgumentError
    user_date = get_date(position)
  end
  return user_date
end
def date_error_message
  puts "Those dates don't sem right..."
end
a = Artii::Base.new :font => 'slant'

puts "Welcome to ..."
puts a.asciify('Hotelie')
reply = true
while reply
  puts "Options:"
  puts menu
  puts ""
  print "Selection #: "
  user = gets.chomp.to_i
  until user > 0 && user < 8
    puts "Oops.. I didn't understand"
    print "Selection # (1-7): "
    user = gets.chomp.to_i
  end

  case user
  when 1 #find a available room
    puts "Let's find an available room!"
    broken = true
    while broken
      start_date = get_date("start")
      end_date = get_date("end")
      begin
        all_rooms = Hotel::Room.all_available_rooms(start_date, end_date)
        broken = false
      rescue DateError
        date_error_message
        broken = true
      end
    end
    print_rooms(all_rooms)
  when 2 #reserve a room
    puts "Let's reserve a room!"
    broken = true
    while broken
      start_date = get_date("start")
      end_date = get_date("end")
      print "Which room do you want to reserve? "
      room_number = gets.chomp.to_i
      begin
        room_reservation = Hotel::Reservation.new(start_date, end_date, Hotel::Room.new(room_number))
        broken = false
      rescue DateError
        date_error_message
        broken = true
      rescue InvalidRoomError
        puts "That room isn't available..."
        broken = true
      end
    end
    puts room_reservation.to_s
  when 3 #view a list of reservations
    puts "Let's view a list of reservations!"
    date = get_date("reservation")
    list = Hotel::Reservation.list_for_date(date)
    if list.empty?
      puts "No reservations for #{date}"
    else
      list.each do |reservation|
        puts "- #{reservation.to_s}"
      end
    end
  when 4 #create a block
    puts "Let's reserve a block of rooms!"
    broken = true
    while broken
      start_date = get_date("start")
      end_date = get_date("end")
      print "How many rooms? "
      num = gets.chomp.to_i
      print "Discounted rate: "
      rate = gets.chomp.to_i
      print "Request name: "
      name = gets.chomp
      begin
        Hotel::Reservation.block_rooms(start_date, end_date, num, rate, name)
        broken = false
      rescue DateError
        date_error_message
        broken = true
      rescue InvalidRoomError
        puts "Invalid number of rooms..."
        broken = true
      end
    end
  when 5 #check block availability
    puts "Let's check if there are any block rooms!"
    print "Request name: "
    name = gets.chomp
    available = Hotel::Reservation.block_availability(name)
    puts available ? "Yes, there are rooms available!" : "Sorry, there are no rooms under that name :("
  when 6 #reserve a block room
    puts "Let's reserve a block room!"
    print "Request name: "
    name = gets.chomp
    begin
      reservation = Hotel::Reservation.reserve_block_room(name)
      broken = false
    rescue InvalidRoomError
      puts "No rooms available in this block"
    end
    puts reservation.to_s
  else #view room list
    hotel = Hotel::Room.list_all
    print_rooms(hotel)
  end

  print "Choose another option? (y/n) "
  reply = gets.chomp.downcase
  if reply == "y"
    reply = true
  else
    reply = false
  end
end
