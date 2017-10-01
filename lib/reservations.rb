require 'date'
require 'rooms'

module Hotels
  class Reservations
    attr_reader :room, :date_range
    def initialize(room, date_range)
      @room = room
      @date_range = date_range
    end

    def calculate_bill
      cost = @date_range.length * @room.price
      return cost
    end

    #check to make sure in future, end_date is after start_date
        def self.check_dates(start_date, end_date)
          date_array = []
          if Date.valid_date?(start_date[0], start_date[1], start_date[2]) && Date.valid_date?(end_date[0], end_date[1], end_date[2])
          start_date = Date.new(start_date[0], start_date[1], start_date[2])
          end_date = Date.new(end_date[0], end_date[1], end_date[2])
            if (start_date < end_date) && (start_date == Date.today || ((start_date > Date.today)))
              date_array << start_date
              date_array << end_date
            else
              raise ArgumentError.new("Invalid dates.")
            end
          else
            raise ArgumentError.new("Invalid dates.")
          return date_array
          end
        end

        def self.date_range(date_array)
          date_range = []
          until date_array[0] == date_array[1]
            date_range << date_array[0]
              date_array[0] += 1
          end
            return date_range
        end

  end
end
