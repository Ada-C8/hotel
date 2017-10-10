require 'date'
require_relative 'hotel_methods'


module Hotel
  class Room
    attr_reader :price
    attr_accessor :bookings

    def initialize(price = 200)
      @price = price
      @bookings = Array.new
    end

    def book(arrival_date, departure_date)
      arrival = Hotel.date_ify(arrival_date)
      departure = Hotel.date_ify(departure_date)
      # raise ArgumentError.new("Must enter date") if arrival.class != Date
      # raise ArgumentError.new("Must enter date") if departure.class != Date
      if booked?(arrival,departure)
        return false
      else
        @bookings << {arrival: arrival, departure: departure}
        return true
      end

    end

    private

    def booked?(arrival_date, departure_date)
      @bookings.each do |stay|
        if (arrival_date >=  stay[:arrival] && arrival_date < stay[:departure]) || (stay[:arrival] >=  arrival_date && stay[:departure] < departure_date)
          return true
        end
      end
      return false
    end

  end # class Room
end # module Hotel
