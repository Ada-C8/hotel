require_relative './concerns/dateable'
require_relative './concerns/reserveable'
require_relative './concerns/blockable'
require_relative 'reservation'
require 'date'
require 'securerandom'
require 'pry'
module Hotel


  class Admin
    include Hotel::Dateable::InstanceMethods
    include Hotel::Reserveable::InstanceMethods
    include Hotel::Blockable::InstanceMethods

    attr_reader :reservations_list, :all_rooms, :block_list
    # def get_date_range(check_in, check_out)
    #   return  (check_in ... check_out).to_a
    # end

    def initialize
      @reservations_list = []
      @block_list = []
      @all_rooms = []
      make_hotel_rooms
    end
    #could possibly go back in here and use a rooms class
    def make_hotel_rooms
      (1..20).each do |num|
        @all_rooms << num #Hotel::Room.new(num) I don't think I have to do this
      end
    end

  end #class Admin

end 
