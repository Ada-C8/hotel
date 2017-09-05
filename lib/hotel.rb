require_relative "rooms"

class Hotel
  attr_reader :rooms
  def initialize
    @rooms = []

    (1..20).each do |room|
      @rooms.push(Room.new(room))
    end
  end

#this is an interface feature
  # def show_all_rooms
  #   room_display = []
  #   @rooms.each do |room|
  #     return
  #   end
  #   return room_display
  # end

  def check_status(room_number, date_start, date_end)
    #will call on the room's status/reservations
  end

  def find_by_room_num(num)
    #will return the room object if the number matches the room number
    #we don't want this to return the room object but rather the details of the room
  end

  def make_reservation(room_number, date_start, date_end)
    #will create new instance of resveration on a hotel room
  end

  def available_rooms(date_start, date_end)
    #will sort rooms by status and display those that are available for the input date
  end
end
