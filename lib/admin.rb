require_relative './concerns/dateable'
require_relative './concerns/reserveable'
require_relative 'reservation'
require 'date'
require 'securerandom'
require 'pry'
module Hotel


  class Admin
    include Hotel::Dateable::InstanceMethods
    include Hotel::Reserveable::InstanceMethods

    attr_reader :reservations_list, :all_rooms, :block_list
    # def get_date_range(check_in, check_out)
    #   return  (check_in ... check_out).to_a
    # end

    def initialize
      @reservations_list = []
      @block_list = {}
      @all_rooms = []
      make_hotel_rooms
    end
    #could possibly go back in here and use a rooms class
    def make_hotel_rooms
      (1..20).each do |num|
        @all_rooms << num #Hotel::Room.new(num) I don't think I have to do this
      end
    end

    #ablity to do block things
    #what I want to do is block off the amount of rooms that are required for the block
    #can change number of blocks in reserved block
    def create_block(check_in, check_out, name, contact_info, discount, num_rooms)
      num_rooms_in_range?(num_rooms)
      #id_num = SecureRandom.uuid don't need it, but I like the idea

      Hotel::Block.new(check_in, check_out, name, contact_info, discount, num_rooms)

    end

    def num_rooms_in_range?(num)
      0 < num <= @all_rooms.length ? true : ArgumentError.new("The number of rooms is out of range")
    end
    # def finder(search_term, instance_variable)
    #   reservations_list.find_all{|reservation| reservation.send(instance_variable).include?(search_term)}
    # end

    def convert_block_to_reservation(name)
      being_converted = finder(name, :name, block_list)
      being_converted.num_rooms.times do
      available_rooms = rooms_available?(being_converted.check_in, being_converted.check_out)
      reserve(being_converted.name, being_converted.check_in, being_converted.check_out, available_rooms[0], being_converted.name, being_converted.contact_info)
    end
    @block_list.delete(being_converted)

    end



    def delete_block(name)
      finder(name, :name, block_list)
    end



    # #ability to do searchy things
    # def finder(search_term, instance_variable)
    #   reservations_list.find_all{|reservation| reservation.send(instance_variable).include?(search_term)}
    # end
  end #class Admin

end #module Hotel
