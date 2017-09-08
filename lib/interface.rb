require_relative 'Hotel'
require 'terminal-table'

#adding these clear methods for now so i can clear everything out in the interface
module Hotel
  class Room
    def self.clear
      @@rooms = []
    end
  end

  class Reservation
    def self.clear
      @@reservations = []
    end
  end

  class Block
    def self.clear
      @@blocks = []
    end
  end
end

def create_date(datestring)
  Date.new(datestring[-4..-1].to_i, datestring[0..1].to_i, datestring[3..4].to_i)
end

def input_dates
  puts "What is the check-in date? (mm/dd/yyyy)"
  input_start_date = gets.chomp
  start_date = create_date(input_start_date)
  puts "What is the check-out date? (mm/dd/yyyy)"
  input_end_date = gets.chomp
  end_date = create_date(input_end_date)
  return [start_date, end_date, input_start_date, input_end_date]
end

def list_rooms
  table = Terminal::Table.new :headings => ['Room', 'Rate']
  Hotel::Room.all.each do |room|
    table << [room.room_num, room.rate]
  end
  puts table
end

def list_available_rooms
  dates = input_dates
  start_date, end_date, input_start_date, input_end_date = dates[0], dates[1], dates[2], dates[3]
  table = Terminal::Table.new :headings => ['Room']
  Hotel::Reservation.available(start_date, end_date).each do |room|
    table << [room]
  end
  puts "The following rooms are available for #{input_start_date} to #{input_end_date}"
  puts table
end

def make_reservation
  puts "If the room is part of a block, enter the block number. Otherwise enter 'no'."
  input = gets.chomp.downcase
  until input == 'no' || input.class == Integer
    puts "Invalid response. If the room is part of a block, enter the block number. Otherwise enter 'no'."
    input = gets.chomp.downcase
  end
  block_id = input if input != 'no'
  block_id = nil if input == 'no'
  dates = input_dates
  start_date, end_date, input_start_date, input_end_date = dates[0], dates[1], dates[2], dates[3]
  puts "If you'd like to select a specific room, enter the room number. Otherwise enter 'no'."
  room_num = gets.chomp.downcase
  until Hotel::Room.all.map {|room| room.room_num}.include?(room_num.to_i) or room_num == 'no'
    puts "Invalid room number. If you'd like to select a specific room, enter the room number. Otherwise enter 'no'."
    room_num = gets.chomp.downcase
  end
  room_num = 0 if room_num == 'no'
  room_num = room_num.to_i
  begin
    reservation = Hotel::Reservation.new(block_id, start_date, end_date, room_num)
    puts "Your reservation was successful. Room #{reservation.room_num} is reserved from #{input_start_date} to #{input_end_date}. The total is $#{reservation.total}."
  rescue
    puts "ERROR: Your reservation was not successful."
  end
end

(1..20).each { |num| Hotel::Room.new(num) }

welcome = "Welcome to your hotel booking system."
menu = <<MENU
What would you like to do?
1) List rooms in the hotel
2) List available rooms for given dates
3) Reserve a room
4) See all reservations (date optional)
5) See the total for a reservation
6) Create a block of rooms
7) See available rooms in a block
8) Change the rate for a room
Type "exit" to leave this session.
MENU

puts welcome + menu
input = gets.chomp.downcase
until input == "exit"
  case input
    when "1"
      list_rooms
    when "2"
      list_available_rooms
    when "3"
      make_reservation
    when "4"
    when "5"
    when "6"
    when "7"
    when "8"
  end
  puts menu
  input = gets.chomp.downcase
end
