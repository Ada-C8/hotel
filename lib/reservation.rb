require 'date'
require 'pry'

module Hotel
  class Reservation
    attr_reader :client, :arrival_date, :departure_date, :number_of_rooms, :type

    def initialize(client, arrival_date, departure_date, number_of_rooms)
      @client = client.gsub(/[A-Za-z']+/,&:capitalize)
      @arrival_date = Date.parse(arrival_date.sub(/[\/]/, '-'))
      @departure_date = Date.parse(departure_date.sub(/[\/]/, '-'))
      @number_of_rooms = number_of_rooms.to_i
      @room_price = 200.00
      @type = "Regular"
    end

    def stay_length
      if @departure_date <= @arrival_date
        raise ArgumentError.new("Your departure date can't be before your arrival date.")
      end
      return (@departure_date - @arrival_date).to_i
    end

    def total
      return "%.2f" % (@room_price * stay_length * @number_of_rooms)
    end

    def summary
      puts "Name: #{client}"
      puts "Dates: From #{arrival_date} to #{departure_date}"
      puts "Stay length: #{stay_length}"
      puts "Number of rooms: #{number_of_rooms}"
      puts "Type: #{type}"
      puts "Total price: #{total}"
    end

  end # End of class Reservation
end #End of Hotel module
