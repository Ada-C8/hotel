require 'date'
require_relative "room.rb"
require_relative "admin.rb"
require_relative "reservation.rb"
require_relative "block_reservation.rb"

#Errors
Dir[File.dirname(__FILE__) + '/errors/*.rb'].each {|file| require file }
