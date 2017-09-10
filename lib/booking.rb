# Booking will do a lot of things:
# It will initialize all the instances of the Room class (with room_number 1-20)
# it will be initialized with an emty array @all_reservations and an array @all_rooms that containts the 20 initialized instances of Room
# It will initialize all the instances of the Room class (with room_number 1-20)
# It will have an instance variable @all_reservations which will be an array of all the Reservation instances created in the Booking class
# It will have a method that makes a new reservation
# Before it creates a new Reservation it will need to verify that the hotel has vacancy for the date(s) in question
#Once it verifies that there is availiblility it will create a new instance of Reservation with a reservation_id (unique to each Reservation @all_reservations.length + 1? ), total_cost (# of rooms * number of nights * cost of a room), res_rooms (the instsances of the Room class that are included in the Reservation, identified by Room.room_number), date_range (get from the user as a starting and ending date and pass to DateRange to get the date_range argument)
# using the availible array we can iterate though the array to create new Reservation for the date(s) requested with the right rooms (only the ones in the availible array)
# it will have a method that checks if there is a reservation for the date(s) requested
# iterate though @all_reservations for each day requested and if the day is included in the Booking then it will look at the Reservation that included that date and add the room(s) in that reservation to a new array not_availible.
# it will have a method that checks if there is availiblility for the date(s) requested
# if the size of not_availible is 20, then there is no availiblility for that date
# if  20 - not_availible.length > the number of rooms requested then there is availibility for those dates
# then should create the inverse array of not_availible, which i'll call availible
# In ithe make_reservation method: using the availible array we can iterate though the array to create a new Reservation for the date(s) requested with the right rooms (only the ones in the availible array)

require_relative 'exceptions'
require 'pry'

module Hotel
  class Booking
    attr_reader :all_reservations, :all_rooms, :all_blocks
    def initialize
      @all_reservations = []
      @all_rooms = []
      @all_blocks = []
      (1..20).each do |number|
        @all_rooms << Hotel::Room.new(number)
      end
    end # initialize

    def valid_dates(start_date, end_date)
      if end_date < start_date
        raise BookingError.new("Your checkout day must be after your checkin date! You entered: checkin day = #{start_date} and checkout date = #{end_date}")
      elsif end_date == start_date
        raise BookingError.new("You must book at least one night. You entered: checkin day = #{start_date} and checkout date = #{end_date} ")
      end # if
    end # valid_dates

    def get_date_array(start_date, end_date)
      dates = Hotel::DateRange.new(start_date, end_date).nights_booked
    end # get_date_array

    def get_rooms(start_date, end_date, num)
      availible = availible_rooms(start_date, end_date)
      rooms = []
      i = 0
      num.times do
        rooms << availible[i]
        i += 1
      end # .times
      return rooms
    end # get_rooms

    def make_reservation(start_date, end_date, num_rooms )
      valid_dates(start_date, end_date)
      if start_date < end_date
        availible = availible_rooms(start_date, end_date)
        if num_rooms > 20
          raise BookingError.new("You can't reserve that many rooms because we only have 20 rooms in the hotel.")
        elsif num_rooms > availible.length
          raise BookingError.new("We don't have that many rooms availible for those dates. We only have #{availible.length} rooms availible for those dates. ")
        end # if/elsif
        dates_booked = get_date_array(start_date, end_date)
        reservation_id = @all_reservations.length + 1
        rooms = get_rooms(start_date, end_date, num_rooms)
        cost = (num_rooms * dates_booked.length * 200.0)
        @all_reservations << Hotel::Reservation.new(reservation_id, cost, rooms, dates_booked)
      end # if/else
    end # make_reservation


    def check_date_for_reservations(start_date, end_date)
      # it will have a method that checks if there is a reservation for the date(s) requested
      # iterate though @all_reservations for each day requested and if the day is included in the Booking then it will look at the Reservation that included that date and add the room(s) in that reservation to a new array not_availible.
      days = get_date_array(start_date, end_date)
      date_reservations = []
      days.each do |day|
        @all_reservations.each do |res|
          if res.date_range.include?(day)
            if !(date_reservations.include?(res))
              date_reservations << res
            end
          end # if
        end # .each
      end #.each
      return date_reservations
    end # check_date_for_reservations

    def print_reservations(start_date, end_date)
      # Not sure if we need this and if simply calling check_date_for_reservations is enough for the user to be able to access all the reservations for a given date(range)?
      reservations = check_date_for_reservations(start_date, end_date)
      nice_format_reservations = []
      reservations.each do |res|
        loop_array = []
        loop_array << "Reservation ID: #{res.res_id}"
        loop_array << "Total cost: $#{res.total_cost}"
        list_rooms = ""
        res.res_rooms.each do |room|
          list_rooms << " #{room.room_number},"
        end #.each
        loop_array << "Rooms reserved: #{list_rooms}"
        loop_array << "Date range: #{res.date_range[0]} - #{res.date_range[-1] + 1}"
        nice_format_reservations << loop_array
      end
      return nice_format_reservations
    end #print_reservations

    def availible_rooms(start_date, end_date)
      reservations = check_date_for_reservations(start_date, end_date)
      blocks = check_date_for_block(start_date, end_date)
      reserved = []
      blocked = []
      availible = []
      #creates an array of all the rooms that are reserved for the given date range
      reservations.each do |res|
        res.res_rooms.each do |room|
          reserved << room
        end # .each
      end # .each
      #creates an array of all the rooms that are in a block for the given date range
      blocks.each do |block|
        block.block_rooms.each do |room|
          blocked << room
        end # .each
      end # .each
      # creates an array of all the availible rooms for the given date range
      @all_rooms.each do |room|
        if !(reserved.include?(room)) && !(blocked.include?(room))
          availible << room
        end # if
      end # .each
      return availible
    end # availible_rooms

    def make_block(block_id, start_date, end_date, num_of_rooms)
      availible = availible_rooms(start_date, end_date)
      all_block_id = return_all_block_ids
      block_id = block_id.upcase
      valid_dates(start_date, end_date)
      if num_of_rooms > 5
        raise BookingError.new("You can only request a maximum of five rooms per block.")
      elsif num_of_rooms > availible.length
        raise BookingError.new("You cannot request that many rooms for your block. There are only #{availible.length} rooms left for that date range.")
      elsif all_block_id.include?(block_id)
        raise BookingError.new("Please use a different block ID, the block ID #{block_id} is already in use")
      end # if/elsif
      dates = get_date_array(start_date, end_date)
      rooms = get_rooms(start_date, end_date, num_of_rooms)
      @all_blocks << Hotel::Block.new(block_id, rooms, dates)
    end #make_block

    def check_date_for_block(start_date, end_date)
      days = get_date_array(start_date, end_date)
      date_blocks = []
      days.each do |day|
        @all_blocks.each do |block|
          if block.date_range.include?(day)
            if !(date_blocks.include?(block))
              date_blocks << block
            end # if
          end # if
        end # .each
      end # .each
      return date_blocks
    end # check_date_for_block

    def return_all_block_ids
      all_block_id = []
      @all_blocks.each do |block|
        all_block_id << block.block_id
      end # .each
     return all_block_id
   end # return_all_block_ids

    def check_block_availibility(block_id)
      # will iterate though the @all_block array to find the block with the right ID
      # if the block ID doesn't exsist
      # if the ID does exist then it will rerurn the Block.block_rooms array
      # if this array is empty then there is not avaibility
      # if there are rooms in the array then there is still availible in the block
      # Then this array can be passed to the reserve_from_block method so that you can book directly from the block
      #Will have to have another method that will return true or false depending on the return array of the check_block_availibility method to be a simple way to check if there is availibility in the block
      id = block_id.upcase
      all_block_id = return_all_block_ids
      if !(all_block_id.include?(id))
        raise BookingError.new("That booking ID does not exist!")
      end # if
      block_rooms_remaining = []
      @all_blocks.each do |block|
        if block.block_id == id
          block_rooms_remaining = block.block_rooms
        end # if
      end # .each
      return block_rooms_remaining
    end # def check_block_availibility

    def rooms_left_in_block(block_id)
      id = block_id.upcase
      all_block_id = return_all_block_ids
      if !(all_block_id.include?(id))
        raise BookingError.new("That booking ID does not exist!")
      end # if
      rooms_left = check_block_availibility(block_id)
      if rooms_left.length == 0
        return "There are no rooms left in the #{id} block"
      elsif rooms_left.length > 0
        return "There are #{rooms_left.length} rooms left in the #{id} block"
      end # if/elsif
    end # rooms_left_in_block

    def return_one_block(block_id)
      # will return the block that has the ID that you're searching for
      # this method will be called in the reserve_from_block method to reserve a room from a specific block!
      id = block_id.upcase
      all_block_id = return_all_block_ids
      if !(all_block_id.include?(id))
        raise BookingError.new("That booking ID does not exist!")
      end # if
      @all_blocks.each do |block|
        if block.block_id == id
          return block
        end # if
      end # .each
    end # return_one_block

    def reserve_from_block(block_id, num_of_rooms)
      id = block_id.upcase
      all_block_id = return_all_block_ids
      if !(all_block_id.include?(id))
        raise BookingError.new("That booking ID does not exist!")
      end # if
      reservation_id = @all_reservations.length + 1
      block_reservations = return_one_block(id).reserve_room(reservation_id, num_of_rooms)
      block_reservations.each do |res|
        @all_reservations << res
      end # .each
      return block_reservations
    end # reserve_from_block
  end # Booking
end # Hotel
