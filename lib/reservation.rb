#reservation

module HotelManagment
  class Reservation
    attr_reader :name, :check_in_date, :check_out_date

    def initialize(name, check_in_date, check_out_date)
      @name = name
      @check_in_date = check_in_date
      @check_out_date = check_out_date
    end



  end #class end
end #module end
