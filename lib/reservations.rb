require 'date'
module Hotel
  class Reservations

    attr_reader :all_reservations, :rooms, :all_rooms, :not_available, :available, :booking, :num_of_rooms, :collection_of_rooms, :block_id

    def initialize
      # @all_rooms = [1..20] # do I need all_rooms?
      # @rooms = Room.new.room_number
      # @room_cost = 0 # do I need this? I have cost over in booking
      # @cost = Room.new.cost
      @all_rooms = []
      create_rooms(@all_rooms)
      @all_reservations = []

      #####new added thursday night and doesn't work:
      @all_blocks = []
      @all_rooms_in_block = []
      #####end of new code from thursday night
    end

    def create_rooms(all_rooms)
      20.times do |i|
        num = i + 1
        all_rooms << Room.new(num)
      end
    end

    # Booking.new(checkin, checkout, check_availablity[0])
    #Todo:
    # return rooms that are reserved for that date

    def make_booking(checkin, checkout, num_of_rooms = 1)
      # do we have an availability?
      # if yes, Reservation.new and push into @all_reservations
      # make id here and pass into booking
      # date_range = DateRange.new(checkin, checkout)
      availability = check_availability(checkin, checkout)
      if availability.length < num_of_rooms
        raise ArgumentError.new "Sorry, we don't have enough rooms."
      elsif availability == []
        raise ArgumentError.new "Sorry, there are no rooms available."
      end

      id = @all_reservations.length
      rooms = availability.take num_of_rooms

      # puts "Rooms is #{rooms}, type is #{rooms.class}"

      booking = Booking.new(checkin, checkout, rooms, id)
      @all_reservations << booking

      # should I write a loop that tells it to make multiple bookings per num_of_rooms?
      # if num_of_rooms > 1
      #   num_of_rooms.times do
      #     booking * num_of_rooms
      #   end
      # end

      return booking
    end

    def print_reservations
      return @all_reservations
    end



    def check_reservations(checkin, checkout)
      # need to check each find date
      # if reservation.date.include? (date_range[0])
      #   not_available << room
      check_against = DateRange.new(checkin, checkout).night_array
      not_available = []

      check_against.each do |date|
        # check_against.each do |index|

        @all_reservations.each do |booking|
          if booking.dates.include?(date)
            booking.rooms.each do |room|
              not_available << room
            end
          end
        end

        # @all_blocks What if I write the same above?
      end
      # if (checkin == Date.new(2017, 10, 5))
      #   # binding.pry
      # end
      return not_available
    end

    def check_availability(checkin, checkout)
      ##### write logic to check for blocks bc then it's not available
      # this is the inverse of not_available array
      available = []
      @all_rooms.each do |room|
        unless check_reservations(checkin, checkout).include?(room)
          available << room
        end
      end
      # binding.pry
      return available
    end

    ################## ALL NEW THURSDAY NIGHT BLOCK LOGIC #######
    ################## ALL NEW THURSDAY NIGHT BLOCK LOGIC #######
    ################## ALL NEW THURSDAY NIGHT BLOCK LOGIC #######

#### don't need below ####
    # def create_blocks(all_blocks)
    #   20.times do |i|
    #     num = i + 1
    #     all_blocks << Room.new(num)
    #   end
    # end
#### don't need above ####


    def make_block(checkin, checkout, num_of_rooms) #collection_of_rooms
      ###### attempt 2 #########
      available = create_rooms(all_rooms)
      if num_of_rooms > 10
        raise ArgumentError.new "You cannot block more than 10 rooms."
      elsif num_of_rooms > available
        raise ArgumentError.new "There are only  #{available.length} available for your dates."
      else
        rooms = []
        num_of_rooms.times do |i|
          rooms << available[i]
          @all_rooms_in_block << available[i]
        end
        new_block = Hotel::Block.new(checkin, checkout, collection_of_rooms, block_id)
        @all_blocks << new_block
        return new_block
      end
    end

    def check_block_for_availability
      @all_blocks.each do |block|
        block.room_booked.each do |yes_booked|
          if yes_booked == true
            return true
          end
        end
      end
      return false
    end

    def reserve_room_from_block(block_id)
      if @all_blocks == []
        raise ArgumentError.new "No room blocks"
      else
        @all_blocks.each do |block|
          if block.id == block_id
            if block.available.include?(false)
              index = 0
              block.yes_booked.each do |get_a_room|
                if get_a_room[index] == false
                  # checkin = ###
                  # checkout = ###
                  rooms = num_of_rooms ###figure out
                  block_id = block.available[index].number
                  new_rez = Booking.new(checkin, checkout, rooms, block_id)
                  @all_blocks << new_rez
                  get_a_room == true
                end
              end
            else
              puts "There are no rooms avaiable for this block"
            end
          end
        end
      end
    end
  end
      ###### end attempt 2 #########
  #
  #     #### ERROR MESSAGES TO THINK ABOUT WRITING
  #     availability = check_block_availability(checkin, checkout)
  #     # if availability.length a num_of_rooms
  #     #   raise ArgumentError.new "Sorry, we don't have enough rooms."
  #     # elsif availability == []
  #     #   raise ArgumentError.new "Sorry, there are no rooms available."
  #     # end
  #     block_id = @all_blocks.length
  #     collection_of_rooms = availability.take num_of_rooms
  #     block = Block.new(checkin, checkout, collection_of_rooms, block_id)
  #     @all_blocks << block
  #     return block
  #   end
  #
  #   def check_block(checkin, checkout)
  #     check_against = DateRange.new(checkin, checkout).night_array
  #     block_not_available = []
  #     check_against.each do |date|
  #       @all_blocks.each do |block|
  #         if block.dates.include?(date)
  #           block.rooms.each do |room|
  #             not_available << room
  #           end
  #         end
  #       end
  #     end
  #     return block_not_available
  #   end
  #
  #   def check_block_availability(checkin, checkout)
  #     block_available = []
  #     @all_rooms.each do |room|
  #       unless check_block(checkin, checkout).include?(room)
  #         block_available << room
  #       end
  #     end
  #     # binding.pry
  #     return block_available
  #   end
  # end
end
