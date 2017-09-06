require 'date'

module Hotel
  class Reservation
    attr_reader :client, :arrival_date, :departure_date, :number_of_rooms

    def initialize(client, arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day, number_of_rooms)
      @client = client.gsub(/[A-Za-z']+/,&:capitalize)
      @arrival_date = Date.new(arrival_year.to_i, arrival_month.to_i, arrival_day.to_i)
      @departure_date = Date.new(departure_year.to_i, departure_month.to_i, departure_day.to_i)
      @number_of_rooms = number_of_rooms.to_i
      @room_price = 200.00
    end

    def stay_length
      if @departure_date <= @arrival_date
        raise ArgumentError.new("Your departure date can't be before your arrival date.")
      end
      return @departure_date - @arrival_date
    end

    def total
      return @room_price * stay_length * @number_of_rooms
    end

  end # End of class Reservation
end #End of Hotel module
