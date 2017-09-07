module Hotel
  class Hotel
    attr_reader :number_of_rooms, :list_of_rooms, :reservations

    def initialize(number_of_rooms)
      @number_of_rooms = number_of_rooms.to_i
      @reservations = []
      # @room_block = []
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
      available_rooms = available_at_period(arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day)
      if available_rooms == "No avaibility at these dates."
        raise NoAvailableRoomError.new("No avaibility at these dates.")
      elsif available_rooms.length < number_of_rooms.to_i
        raise NoAvailableRoomError.new("Only #{available_rooms.length} rooms available at these dates.")
      else
        number_of_rooms.to_i.times do |i|
          available_at_period(arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day).first.booked << {"arrival" => Date.new(arrival_year, arrival_month, arrival_day), "departure" => Date.new(departure_year, departure_month, departure_day)}
        end
      end
      @reservations << Reservation.new(client, arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day, number_of_rooms)
    end

    def create_block(client, arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day, number_of_rooms)
      available_rooms = available_at_period(arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day)
      if available_rooms == "No avaibility at these dates."
        raise NoAvailableRoomError.new("No avaibility at these dates.")
      elsif available_rooms.length < number_of_rooms.to_i
        raise NoAvailableRoomError.new("Only #{available_rooms.length} rooms available at these dates.")
      else
        number_of_rooms.to_i.times do |i|
          available_at_period(arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day).first.booked << {"arrival" => Date.new(arrival_year, arrival_month, arrival_day), "departure" => Date.new(departure_year, departure_month, departure_day)}
        end
      end
      @reservations << RoomBlock.new(client, arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day, number_of_rooms)
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
        unless room.booked.empty?
          room.booked.each do |stay_hash|
            if date > stay_hash["arrival"] || date < stay_hash["departure"]
              booked = true
              break
            end
          end
        end
        available_rooms << room if booked == false
      end
      if available_rooms.empty?
        return "No avaibility at these dates."
      else
        return available_rooms
      end
    end

    def available_at_period(arrival_year, arrival_month, arrival_day, departure_year, departure_month, departure_day)
      arrival_date = Date.new(arrival_year.to_i, arrival_month.to_i, arrival_day.to_i)
      departure_date = Date.new(departure_year.to_i, departure_month.to_i, departure_day.to_i)
      available_rooms = []
      @list_of_rooms.each do |room|
        booked = false
        room.booked.each do |stay_hash|
          if arrival_date < stay_hash["departure"] || departure_date > stay_hash["arrival"]
            booked = true
          end
        end
        available_rooms << room if booked == false
      end
      if available_rooms.empty?
        return "No avaibility at these dates."
      else
        return available_rooms
      end
    end

  end
end
