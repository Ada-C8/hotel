
=begin
options:
- view a list of rooms
- reserve a room
- view total cost for a reservation
- view a list of reservations for a date
- view avaialbe rooms for a date
- create a block of rooms
- check availability
- reserve a block room


- catch invalid date
- catch unavailable room
- catch room number error
=end
require 'artii'
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

a = Artii::Base.new :font => 'slant'

puts "Welcome to ..."
puts a.asciify('Hotelie')
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
  # ask for date - convert date
  all_rooms = Hotel::Room.all_available_rooms(start_date, end_date)
  print_rooms(all_rooms)
when 2 #reserve a room

when 3 #view a list of reservations

when 4 #create a block

when 5 #check block availability

when 6 #reserve a block room

else #view room list
  hotel = Hotel::Room.list_all
  print_rooms(hotel)
end
