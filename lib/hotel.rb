require 'date'
require_relative 'room'
require_relative 'reservation'

module Hotel

  class California
    attr_reader :all_rooms

    def initialize
      @num_of_rooms = 20
      @rate = 200
      @all_rooms = {}
      (1..@num_of_rooms).each do |room|
        @all_rooms[room] = Hotel::Room.new(room, @rate)
      end
    end

    def find_available(date)
      valid_date = Date.parse(date)
      by_date = []
      @all_rooms.each do |k, v|
        if @all_rooms[k].reservations.length == 0
          by_date << @all_rooms[k].room_num
        elsif @all_rooms[k].reservations.length != 0
          # needs to iterate over reservations
          unless @all_rooms[k].reservations[0].dates.include? valid_date.to_s
            by_date << @all_rooms[k].room_num
          end
        end
      end
      return by_date
    end

    def total(num) # reservation id
      # run 'all_reservations'
      # search by id, reservation creates an id
      # only would return for a specific reservation
      # two arguments? num and reservation?
      num_nights = @all_rooms[num].reservations[0].dates.length - 1
      return num_nights * @rate
    end


    def find_by_date(date)
      valid_date = Date.parse(date)
      by_date = []
      @all_rooms.each do |k, v|
        if @all_rooms[k].reservations.length != 0
          @all_rooms[k].reservations.each_index do |i|
            if @all_rooms[k].reservations[i].dates.include? valid_date.to_s
              by_date << @all_rooms[k]
            end
          end
        end
      end
      return by_date
    end

    def all_reservations
      all = []
      @all_rooms.each do |k, v|
        if @all_rooms[k].reservations.length != 0
          all << @all_rooms[k].reservations
        end
      end
      return all
    end

  end #end of California
end #end of Hotel

new = Hotel::California.new
new.all_rooms[1].create_reservation("2017-03-04", "2017-03-05")
new.all_rooms[4].create_reservation("2017-03-04", "2017-03-19")
p new.all_rooms[1].reservations
