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

def valid_date?(input_date)
  regexdate = /(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.](19|20)\d\d/
  return input_date.match(regexdate) != nil
end

def create_date(datestring)
  Date.new(datestring[-4..-1].to_i, datestring[0..1].to_i, datestring[3..4].to_i)
end

def input_dates
  puts "What is the check-in date? (mm/dd/yyyy)"
  input_start_date = gets.chomp
  until valid_date?(input_start_date) == true
    puts "Invalid date. Enter the check-in date (mm/dd/yyyy)."
    input_start_date = gets.chomp
  end
  start_date = create_date(input_start_date)
  puts "What is the check-out date? (mm/dd/yyyy)"
  input_end_date = gets.chomp
  until valid_date?(input_end_date) == true
    puts "Invalid date. Enter the check-out date (mm/dd/yyyy)."
    input_end_date = gets.chomp
  end
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
  until input == 'no' || Hotel::Block.all.map{|block| block.block_id}.include?(input.to_i)
    puts "Invalid response. If the room is part of a block, enter the block number. Otherwise enter 'no'."
    input = gets.chomp.downcase
  end
  block_id = input.to_i if input != 'no'
  block_id = nil if input == 'no'
  if block_id == nil
    dates = input_dates
    start_date, end_date, input_start_date, input_end_date = dates[0], dates[1], dates[2], dates[3]
  else
    block = Hotel::Block.all.find {|a_block| a_block.block_id == block_id}
    start_date, end_date, input_start_date, input_end_date = block.start_date, block.end_date, block.start_date.to_s, block.end_date.to_s
  end
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

def list_reservations
  puts "Enter the date (mm/dd/yyyy) for which you'd like to view a list of reservations. Otherwise enter 'no'."
  input_date = gets.chomp.downcase
  until input_date == 'no' || valid_date?(input_date) == true
    puts "Invalid date. Enter the date (mm/dd/yyyy) for which you'd like to view a list of reservations. Otherwise enter 'no'."
    input_date = gets.chomp
  end
  input_date = create_date(input_date) if input_date != 'no'
  input_date = nil if input_date == 'no'
  table = Terminal::Table.new :headings => ['Check-in', 'Check-out', 'Room', 'Block', 'Total']
  Hotel::Reservation.all(input_date).each do |reservation|
    table << [reservation.start_date, reservation.end_date, reservation.room_num, reservation.block_id, "$#{reservation.total}"]
  end
  puts table
end

def create_block
  dates = input_dates
  start_date, end_date, input_start_date, input_end_date = dates[0], dates[1], dates[2], dates[3]
  puts "How many rooms should be reserved for the block? (1-5)"
  number_of_rooms = gets.chomp.to_i
  until number_of_rooms.class == Integer && number_of_rooms > 0 && number_of_rooms < 6
    puts "Invalid number of rooms. Enter a number between 1 and 5."
    number_of_rooms = gets.chomp.to_i
  end
  puts "Enter this block's discount. For the default discount, enter 'no'."
  discount = gets.chomp.downcase
  until discount == 'no' || discount.match(/^(0(\.\d+)?|1(\.0+)?)$/) != nil
    puts "Invalid discount. Enter a number between 0 and 1."
    discount = gets.chomp.downcase
  end
  discount = discount.to_f if discount != 'no'
  begin
    block = Hotel::Block.new(start_date, end_date, number_of_rooms, discount) if discount != 'no'
    block = Hotel::Block.new(start_date, end_date, number_of_rooms) if discount == 'no'
    puts "Your block was created with a block number of #{block.block_id}. Rooms #{block.rooms} are reserved from #{input_start_date} to #{input_end_date}"
  rescue
    puts "ERROR: Your block was not created."
  end
end

def list_available_rooms_in_block
  return if Hotel::Block.all.length == 0
  puts "What is the block number?"
  block_id = gets.chomp.to_i
  until Hotel::Block.all.map {|a_block| a_block.block_id}.include?(block_id)
    puts "Invalid block number. Please enter the block number."
    block_id = gets.chomp.to_i
  end
  available_rooms = Hotel::Block.rooms_left(block_id)
  puts "No rooms are left in block #{block_id}" if available_rooms.length == 0
  table = Terminal::Table.new :headings => ['Room']
  Hotel::Block.rooms_left(block_id).each do |room|
    table << [room]
  end
  puts "The following rooms are available \n#{table}" if available_rooms.length > 0
end

def change_rate
  puts "Which room would you like to update?"
  room_num = gets.chomp.to_i
  until Hotel::Room.all.map {|room| room.room_num}.include?(room_num)
    puts "Invalid room number. Which room would you like to update?"
    room_num = gets.chomp.to_i
  end
  puts "What is the new rate for room #{room_num}?"
  rate = gets.chomp.to_i
  until rate > 0
    puts "Invalid room rate. Please enter a number greater than 0."
    rate = gets.chomp.to_i
  end
  begin
    Hotel::Room.update_price(room_num, rate)
    puts "Room #{room_num} has a new rate of $#{rate}."
  rescue
    puts "ERROR: The room's rate was not updated."
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
5) Create a block of rooms
6) See available rooms in a block
7) Change the rate for a room
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
      list_reservations
    when "5"
      create_block
    when "6"
      list_available_rooms_in_block
    when "7"
      change_rate
  end
  puts menu
  input = gets.chomp.downcase
end
