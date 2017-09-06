require 'date'

module Hotel

  class DateRange
    attr_reader :checkin, :checkout

    def initialize(checkin, checkout)
      @checkin = checkin
      @checkout = checkout
    end
  end #end of class

end #end of module
