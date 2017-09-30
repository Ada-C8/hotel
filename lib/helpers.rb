module Helpers
  def find_res_by_date(date)
    self.reservations.select do |reservation|
      reservation.includes?(date)
    end
  end
end
