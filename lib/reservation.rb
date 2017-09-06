require_relative 'date_range'

module BookingSystem
  class Reservation

    @@id_count = 1
    COST = 200

    attr_reader :id, :date_range, :room, :total_cost

    def initialize(date_range, room)
      @id = @@id_count
      @@id_count += 1
      @date_range = date_range
      @room = room
      @total_cost = COST * date_range.dates_within_range.length
      puts "Reservation  was created"

    end #end of initialize




  end #end of class

end #end of module
