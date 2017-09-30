# require_relative 'hotel'
#
# module Cli
#   def self.welcome
#     puts "WELCOME to Reservation Manager!"
#   end
#
#   def self.options(whatcha_want)
#     puts "What would you like to do? You can: "
#     i = 1
#     whatcha_want.each do |key, value|
#       puts "#{key}: #{value}"
#       i += 1
#     end
#     "\n Please select the number corresponding to your option."
#   end
#
#   def self.get_input(question)
#     puts "#{question}"
#     answer = gets.chomp
#     return answer
#   end
#
#   def self.execute_choice(choice)
#
#   end
#
#   def self.get_check_in
#     puts "What is the check-in date?"
#     check_in = gets.chomp
#     return check_in
#   end
#
#   def self.get_check_out
#     puts "What is the check-out date?"
#     check_out = gets.chomp
#     return check_out
#   end
#
# end
#
#
# hotel = Hotel.new
#
# options = {
#   1 => "create reservation",
#   2 => "check available rooms",
#   3 => "find rooms reserved by date",
#   4 => "find a reservation by date"
# }
#
# Cli.welcome
# puts "Would you like to continue?"
# answer = gets.chomp.downcase
#
# while answer == "yes"
# question = Cli.options(options)
# Cli.execute_choice(Cli.get_input(question))
# puts "Would you like to continue?"
# answer = gets.chomp.downcase
# end
