#reservation

module HotelManagment
  class Reservation
    attr_reader :first_name, :last_name, :check_in_date, :check_out_date, :reservation_number

    def initialize(first_name, last_name, check_in_date, check_out_date, reservation_number)
      @first_name = first_name
      @last_name = last_name
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @reservation_number = reservation_number
    end


  end #class end
end #module end
