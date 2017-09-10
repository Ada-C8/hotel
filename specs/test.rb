require 'date'
require_relative 'spec_helper'
hotel1 = Hotel::Reservations.new
checkin = Date.new(2017,9,5)
checkout = Date.new(2017,9,7)
hotel1.make_booking(checkin, checkout)
hotel1.make_block(checkin, checkout, 4, "wedding")
binding.pry
puts hotel1


############### comments from room.rb ##############
# require 'date'
#
# module Hotel
#   class Room
#     attr_reader :cost, :arr_rooms # :room_number
#
#
#     def initialize
#       @arr_rooms = []
#       @cost = 200
#       room_number
#     end
#
#     def room_number
#       n = 1
#       20.times do
#         @arr_rooms << n
#         n += 1
#       end
#       return @arr_rooms
#     end
#
#   end
# end

############### comments from booking.rb ##############

# def block_total_cost
#   block_total_cost = 0
#   @collection_of_rooms_blocked.each do |room|
#     block_total_cost += room.cost * @dates.total_nights * 0.80
#   end
#   return block_total_cost
# end



# def assign_room_number
#   1..20.times do
#
#   end
# end

############### comments from date_range.rb ##############


# checkin = Date.new(2017,9,5)
# checkout = Date.new(2017,9,8)
# trip = Hotel::DateRange.new(checkin, checkout)
# trip.check_valid
# puts trip.make_night_array


# first try :
# def make_night_array
#   if check_valid == true
#     counter = 0
#     @total_nights.times do
#       @night_array << Date.new(@checkin + counter)
#       counter += 1
#     end
#   end
#   return @night_array
# end


############### comments from block.rb ##############


    # if @collection_of_rooms_blocked == []
    #   raise ArgumentError.new "No room blocks exist yet"
    # else
    #   @collection_of_rooms_blocked.each do |room|
    #     if block_id == @block_id
    #
    #
    #       if room.available.include?(true) #wait or false?
    #         index = 0
    #         block.collection_of_rooms_blocked.each do |get_a_room|
    #           if get_a_room[index] == false
    #             checkin = new_block
    #             checkout = new_block
    #             # rooms = how_many_rooms ###figure out
    #             # block_id = # string? or block.available[index].number
    #             new_rez = Booking.new(checkin, checkout, rooms, block_id)
    #             #(checkin, checkout, collection_of_rooms_blocked, block_id)
    #
    #             @collection_of_rooms_blocked << new_rez
    #             @all_reservations << new_rez
    #             get_a_room == true
    #           end
    #         end
    #       else
    #         puts "There are no rooms avaiable for this block"
    #       end
    #     end
    #   end


########### comments from reservations.rb ############
#from availability check 
# elsif availability == []
#   raise RoomAvailabilityError.new "Sorry, there are no rooms available."



#from make_booking method:
# should I write a loop that tells it to make multiple bookings per num_of_rooms?
# if num_of_rooms > 1
#   num_of_rooms.times do
#     booking * num_of_rooms
#   end
# end
# @check_block_id



# from initialize:
# @all_rooms = [1..20] # do I need all_rooms?
# @rooms = Room.new.room_number
# @room_cost = 0 # do I need this? I have cost over in booking
# @cost = Room.new.cost


#collection_of_rooms
###### attempt 2 #########
# available = create_rooms(all_rooms)
# block_id = block_id think about unique ids


#########


    #### don't need below ####
    # def create_blocks(all_blocks)
    #   20.times do |i|
    #     num = i + 1
    #     all_blocks << Room.new(num)
    #   end
    # end
    #### don't need above ####


    # tester = Hotel::Reservations.new
    # tester.make_booking


    # block1 = Hotel::Reservations.new
    # checkin1 = Date.new(2018,9,1)
    # checkout1 = Date.new(2018,9,7)
    # block1.make_block(checkin1, checkout1, 5, "wedding")
    # puts block1

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



    ########### comments from reservations_spec.rb #########


    # block8 = hotel8.make_block(checkin8, checkout8, [], "sweet_16")
    #
    # block8.reserve_room_from_block("sweet_16").must_equal true

# describe "check_block_for_availability" do
#   checkin = Date.new(2018,10,1)
#   checkout = Date.new(2018,10,7)
#   block2 = Hotel::Reservations.new.make_block(checkin, checkout, 5, "wedding")
#   block2.check_block_for_availability(checkin, checkout, "wedding").must_be_kind_of Array
# end

# @dates = Hotel::DateRange.new(@checkin, @checkout)
# date_range = Hotel::DateRange.new(@checkin, @checkout)
#
# room = @hotel1.all_rooms[0]
# @res1 = Hotel::Booking.new(@checkin, @checkout, [room], 1)
# @hotel1.all_reservations << @res1
# @res1 = @hotel1.mak
# @res2 = @hotel1.make_booking(@checkin, @checkout, 1 )
# implicitly shoveled @hote1.all_reservations << @res2

#   @res1 = Hotel::Booking.new(checkin, checkout, [Hotel::Room.arr_rooms[1]], 1)
#   @res2 = Hotel::Booking.new(checkin, checkout, [Hotel::Room.arr_rooms[2]], 2)
#   @res3 = Hotel::Booking.new(checkin, checkout, [Hotel::Room.arr_rooms[3]], 3)
#   @hotel1.all_reservations = [@res1, @res2, @res3]
# end
# before do
#    @hotel_res = Hotel::Reservations.new
#
#    @start_date = Date.new(2017,9,1)
#    @end_date = Date.new(2017,9,3)
#    date_range = Hotel::DateRange.new(@start_date, @end_date)

#    room = @hotel_res.all_rooms[0]
#    booking1 = Hotel::Booking.new(1, [room], date_range)
#         (id, rooms, date_range)
#    @hotel_res.all_reservations << booking1
#
#    @booking2 = @hotel_res.make_booking(1, @start_date, @end_date)
#  end

# errors that that admin could mess up:
# THIS FAILS:
# it "is and instance of Reservations" do
#   @hotel1.must_be_instance_of Hotel::Reservations
# end

# it "before a reservation can be made, it checks availablity" do
# end

# it "must check if date range is available" do
#   res1.check_reservation
# end

# it "if we have availability, it creates a reservation" do
#
# end
#
# it "all_reservations is an array of all reservations" do
#
# end
#
#
# it "reservation is pushed into all_reservations array" do
#
# end
