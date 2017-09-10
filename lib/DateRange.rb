require 'date'

module Hotel
  class DateRange
    attr_accessor :dates
    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
      #@dates = []
    end

    def dates  #Add @dates here?
    return Array(@check_in..@check_out)
    end


    # class InvalidCardNumberError < StandardError
    # end
    #
    # def process_transaction(card_number, amount)
    #   # card_is_valid? is defined elsewhere
    #   unless card_is_valid?(card_number)
    #     raise InvalidCardNumberError.new("Invalid credit card number #{card_number}")
    #   end
    #   # ... process the transaction ...
    # end


  end
end
