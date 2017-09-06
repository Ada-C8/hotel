require_relative 'reservations'
require_relative 'rooms'


module Hotel
  class Hotel

  attr_reader :rooms, :reservations

  def initialize
    @rooms = []
    @reservations = []
    create_rooms
  end

  def make_reservation(guest, check_in, check_out)
    reservations << Reservation.new(guest, check_in, check_out)
  end

  def get_res_by_date(date)
    res_by_date = []
    i = 0
    @reservations.each do |res|
      if res.include_date?(date)
        res_by_date << res
        puts i
      end
      i += 1
    end
    return res_by_date
  end

  private

  def create_rooms
    (1..20).each do |num|
      @rooms << Room.new(num)
    end
  end

  end #end of class
end #end of module
