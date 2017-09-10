module Hotel
  class Hotel
    attr_reader :number_of_rooms, :list_of_rooms, :reservations

    def initialize(number_of_rooms)
      @number_of_rooms = number_of_rooms.to_i
      @reservations = []
      @list_of_rooms = Array.new
      @number_of_rooms.times do |i|
        @list_of_rooms << Room.new(i+1)
      end
    end

    def make_reservation(client, arrival_date, departure_date, number_of_rooms)
      available_rooms = available_at_period(arrival_date, departure_date,)
      if available_rooms == nil
        raise NoAvailableRoomError.new("No avaibility at these dates.")
      elsif available_rooms.length < number_of_rooms.to_i
        raise NoAvailableRoomError.new("Only #{available_rooms.length} rooms available at these dates.")
      else
        number_of_rooms.to_i.times do |i|
          available_at_period(arrival_date, departure_date,).first.booked << {"arrival" => Date.parse(arrival_date.sub(/[\/]/, '-')), "departure" => Date.parse(departure_date.sub(/[\/]/, '-'))}
        end
      end
      @reservations << Reservation.new(client, arrival_date, departure_date, number_of_rooms)
    end

    def create_block(client, arrival_date, departure_date, number_of_rooms)
      available_rooms = available_at_period(arrival_date, departure_date)
      if find_block(client) != nil
        raise ArgumentError.new("This client already has a room block")
      elsif available_rooms == nil
        raise NoAvailableRoomError.new("No avaibility at these dates.")
      elsif available_rooms.length < number_of_rooms.to_i
        raise NoAvailableRoomError.new("Only #{available_rooms.length} rooms available at these dates.")
      else
        number_of_rooms.to_i.times do |i|
          available_at_period(arrival_date, departure_date).first.booked << {"arrival" => Date.parse(arrival_date.sub(/[\/]/, '-')), "departure" => Date.parse(departure_date.sub(/[\/]/, '-'))}
        end
      end
      @reservations << RoomBlock.new(client, arrival_date, departure_date, number_of_rooms)
    end

    def find_block(client_name)
      @reservations.each do |reservation|
        if reservation.class == RoomBlock
          if reservation.client == client_name.gsub(/[A-Za-z']+/,&:capitalize)
            return reservation
          end
        end
      end
      return nil
    end

    def find_reservation(client_name)
      @reservations.each do |reservation|
        if reservation.class == Reservation
          if reservation.client == client_name.gsub(/[A-Za-z']+/,&:capitalize)
            return reservation
          end
        end
      end
      return nil
    end

    # def reservations_by_date(date)
    #   reservations_at_date = []
    #   date = Date.parse(date.sub(/[\/]/, '-'))
    #   @reservations.each do |reservation|
    #     if date >= reservation.arrival_date && date < reservation.departure_date
    #       reservations_at_date << reservation
    #     end
    #   end
    #   return reservations_at_date
    # end

    def available_at_date(date)
      date = Date.parse(date.sub(/[\/]/, '-'))
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
        return nil
      else
        return available_rooms
      end
    end

    def available_at_period(arrival_date, departure_date)
      arrival_date = Date.parse(arrival_date.sub(/[\/]/, '-'))
      departure_date = Date.parse(departure_date.sub(/[\/]/, '-'))
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
        return nil
      else
        return available_rooms
      end
    end

  end
end
