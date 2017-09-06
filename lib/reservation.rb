require 'securerandom'

module Hotel
  class Reservation
    attr_reader :check_in_date, :check_out_date

    def initialize(check_in, check_out)
      @check_in = check_in_date
      @check_out = check_out_date
      @id = SecureRandom.uuid
    end

  end
end
