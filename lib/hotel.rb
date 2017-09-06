module Hotel
  class Hotel
    attr_reader :number_of_rooms, :list_of_rooms, :reservations

    def initialize(number_of_rooms)
      @number_of_rooms = number_of_rooms.to_i
      @reservations = []
      @list_of_rooms = create_list_of_rooms
    end

    def create_list_of_rooms
      list_of_rooms = Array.new
      @number_of_rooms.times do |i|
        list_of_rooms << Room.new(i+1)
      end
      return list_of_rooms
    end

    def make_reservation(client, arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day, number_of_rooms)
      @reservations << Reservation.new(client, arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day, number_of_rooms)
      # rooms_booked = 0
      # @list_of_rooms.each do |room|
      #   if room.booked.empty?
      #     room.booked << {"arrival" => Date.new(arrival_year, arrival_month, arrival_day), "departure" => Date.new(departure_year, departure_month, departure_day)}
      #     rooms_booked += 1
      #     break if rooms_booked == number_of_rooms.to_i
      #   end
      # end
      number_of_rooms.to_i.times do |i|
        available_at_date(year, month, day)[i].booked << {"arrival" => Date.new(arrival_year, arrival_month, arrival_day), "departure" => Date.new(departure_year, departure_month, departure_day)}
      end
    end

    def reservations_by_date(year, month, day)
      reservations_at_date = []
      date = Date.new(year.to_i, month.to_i, day.to_i)
      @reservations.each do |reservation|
        if date >= reservation.arrival_date && date < reservation.departure_date
          reservations_at_date << reservation
        end
      end
      return reservations_at_date
    end

    def available_at_date(year, month, day)
      date = Date.new(year.to_i, month.to_i, day.to_i)
      available_rooms = []
      @list_of_rooms.each do |room|
        booked = false
        room.booked.each do |stay_hash|
          return if stay_hash.empty?
          if date > stay_hash["arrival"] && date < stay_hash["departure"]
            return booked = true
          end
        end
        available_rooms << room if booked == false
      end
      return available_rooms
    end

    def available_at_dates(arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day)
      arrival_date = Date.new(arrival_year.to_i, arrival_month.to_i, arrival_day.to_i)
      departure_date = Date.new(departure_year.to_i, departure_month.to_i, departure_day.to_i)
      available_rooms = []
      @list_of_rooms.each do |room|
        booked = false
        room.booked.each do |stay_hash|
          return if stay_hash.empty?
          # #########CHANGE THIS !!!!!!!!!!
          # if arrival_date > stay_hash["arrival"] && date < stay_hash["departure"]
          #   return booked = true
          # end
        end
        available_rooms << room if booked == false
      end
      return available_rooms
    end

  end
end
