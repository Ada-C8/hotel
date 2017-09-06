require 'Date'

module Hotel
  class Reservation

    attr_reader :start_date, :end_date, :room_num

    @@reservations = []

    def initialize(block_id = nil, start_date = Date.today, end_date = Date.today + 1, room_num = 0)
      room_num = Reservation.available(start_date, end_date).sample if room_num == 0
      raise NoRoomsAvailableError.new if room_num.class != Integer
      check_dates(start_date, end_date, room_num)
      @start_date = start_date
      @end_date = end_date
      @room_num = room_num
      collect_instance
    end

    def collect_instance
      @@reservations.push(self)
    end

    def total
      rate = 0
      Room.all.each do |room|
        rate = room.rate if room.room_num == @room_num
      end
      return (@end_date - @start_date) * rate
    end

    def self.all(date = nil)
      return @@reservations if date == nil
      return @@reservations.select { |reservation| reservation.start_date <= date && reservation.end_date >= date }
    end

    def self.available(start_date, end_date)
      available_rooms = Room.all.map { |room| room.room_num }
      overlapping_reservations = @@reservations.select do |reservation|
        self.overlapping?(start_date, end_date, reservation.start_date, reservation.end_date) == true
      end
      overlapping_reservations.each do |reservation|
        available_rooms.delete(reservation.room_num) if available_rooms.include?(reservation.room_num)
      end
      return available_rooms
    end

    private

    def check_dates(start_date, end_date, room_num)
      # prevent invalid dates
      raise InvalidDateError if start_date.class != Date || end_date.class != Date
      raise InvalidDateError if end_date <= start_date
      raise InvalidDateError if start_date < Date.today
      # prevent double booking
      room_reservations = @@reservations.select { |reservation| reservation.room_num == room_num }
      room_reservations.each do |reservation|
        raise AlreadyBookedError if Hotel::Reservation.overlapping?(start_date, end_date, reservation.start_date, reservation.end_date) == true
      end
    end

    def self.overlapping?(start_date, end_date, comparison_start_date, comparison_end_date)
      # start date is within comparison date range
      return true if start_date >= comparison_start_date && start_date < comparison_end_date
      # end date is within comparison date range
      return true if end_date >= comparison_start_date && end_date <= comparison_end_date
      return false
    end


  end # Reservation class
end # Hotel module
