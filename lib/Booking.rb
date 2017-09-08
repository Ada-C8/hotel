### Booking Program class that holds all of the business logic for the hotel and the reservation system
require 'date'
require 'pry'
require_relative 'Reservation'
require_relative 'Room'
require_relative 'Block'

#TODO 09/07/2017:Design logic: Rooms have reservations, have dates, BUT CURRENTLY, Rooms store reservations and all dates on which they are reserved, and that is used to check quickly what rooms are available.
#Rooms also store a hash of Reservation id keys, with their corresponding dates as values, which seems superfluous. RECONSIDER THIS DESIGN. Should Rooms hold Reservation objects only? Reservation objects and dates reserved? maybe just reservation ids and dates? Maybe just reservation ids and helper method that will retrieve the reservation as needed? Think through

## THINK THROUGH: Does a Room create a Reservation based on availability vs. does a Reservation, once created, reserve a room?

module HotelBooking
  # NUMBER_OF_ROOMS = 20  ### might not want to use constant, especially if we have subclasses of rooms (by type), and each room subclass might have a different number. may best be a constant defined by class/subclass

  class Hotel
    attr_reader :all_rooms, :all_reservations, :all_blocks
    NUM_STANDARD_ROOMS = 20
    #NUM_OTHER_ROOMS = 0

    def initialize # do we want to initialize with hotel name?
      # @all_rooms = Hotel::Room.all # returns an array or hash of Room objects
      @all_rooms = HotelBooking::Hotel.setup_rooms
      @all_reservations = []
      @all_blocks = []

    end

    ####should this be a Room, self.all method
    def available_rooms(check_in,check_out, block_id = nil)
      #check_in and #check_out are strings
      #TODO: below
      # confirm check_out date availability logic
      #error handling
      #message if no rooms are available?
      @all_rooms.select {|room| room.available_all_days?(check_in, check_out)}

      #if block_id
    end

    def find_room_by_id(room_id)
      @all_rooms.each {|room| return room if room.id == room_id}

      raise ArgumentError.new "Sorry, we don't have a room matching that ID number."
    end

    def make_block(check_in,check_out,room_ids,discounted_rate)

      raise ArgumentError.new("Number of rooms in a block must be 5 or under") if room_ids.count > 5

      block_id = @all_blocks.count + 1

      block = HotelBooking::Block.new(check_in,check_out,room_ids,discounted_rate,block_id)
      block.room_ids.each do |room_id|
        room = find_room_by_id(room_id)
        room.block_room(check_in,check_out,block_id)
      end

      @all_blocks << block

    end


    ###should this be a Room method
    def make_reservation(check_in,check_out,room_id, block_id = nil, guest_id=nil)

      reservation_id = (@all_reservations.count + 1) #something

      if block_id
        #TODO: think about whether or not to have a separate block reservation id logic and whether or not to store block reservations in the same place as all reservations AND store them separately, or store them in one place (either all reservations or Block reservations)

        all_block_ids = @all_blocks.map {|block| block.id}
        raise ArgumentError.new("This block doesn't exist") if !(all_block_ids.include?(block_id))

        block= find_block_by_id(block_id)
        # binding.pry

        block_discount = block.discounted_rate


        raise ArgumentError.new("This room is not in the block") if !(block.room_ids.include?(room_id))

        #TODO: IRON OUT and TEST block reservation constraints: check in and check out MUST be that of the BLOCK check_in/Check_out dates
        block_check_in = block.check_in.to_s
        block_check_out= block.check_out.to_s

        #TODO: Think about if we want to make a block reservation id a +1 count of all reservations, or have separate ids for blocks
        reservation = HotelBooking::BlockReservation.new(block_check_in,block_check_out,room_id, reservation_id, block_discount)

        reservation.block_id = block_id
      else
        reservation = HotelBooking::Reservation.new(check_in,check_out,room_id, reservation_id,block_id)
      end

      #TODO: How to incorporate reserve_room logic for Block Reservations
      room = find_room_by_id(room_id)
      room.reserve_room(check_in,check_out,reservation.id, guest_id) if reservation.type == :standard

      room.reserve_block_room(check_in,check_out,reservation.id, block_id, guest_id=nil) if reservation.type == :block

      @all_reservations << reservation

    end

    # def make_block_res(check_in,check_out,room_id, block_id, type = :block, guest_id=nil)
    #   room= Hotel::Room.find_by_id(room_id)
    #   block = find_block_by_id(block_id)
    #
    #   raise ArgumentError.new("Error: No block matching that ID number") if !(block)
    #   raise ArgumentError.new("This room isn't included in your block") if !(room.block_id_and_res_dates.keys.include?(block_id))
    #
    #   reservation_id = (@all_reservations.count + 1) #something
    #   reservation = Hotel::Reservation.new(check_in,check_out,room_id, reservation_id,type = :block,guest_id)
    #
    #
    #   reservation.room.reserve_room(check_in,check_out,reservation.id, guest_id)
    #
    #   @all_reservations << reservation
    #
    #
    # end

    def find_res_by_date(date_str)
      date_object= Date.parse(date_str)
      reserved_on_date = []
      @all_reservations.each do |reservation|
        room= find_room_by_id(reservation.room_id)

        reserved_on_date << reservation if room.all_dates.include?(date_object)
      end


        #  {|reservation| reserved_on_date << reservation if reservation.room.all_dates.include?(date_object)}

      return reserved_on_date

      #self.all.select {|reservation| reservation.room.all_dates.include?(date_object)}
    end

    def find_block_res_by_block_id(block_id,guest_id=nil )

    end

    def find_block_by_id(block_id)
      @all_blocks.each do |block|
        return block if block.id == block_id
      end

      return false
    end

    def self.setup_rooms
      i = 1
      standard_rooms = []

      until standard_rooms.count == NUM_STANDARD_ROOMS
        room =  HotelBooking::Room.new(i)
        standard_rooms << room
        i += 1
      end

      return standard_rooms

      #can modify to set up for different types of rooms
    end





    # def find_res_by_guest(guest_id)
    # end
    #

    #
    # def find_res_by_room(room_id)
    # end

    #def find_res_by_id(reservation_id)
    #end

  end

end


# binding.pry

#########WAVE 2 #####
