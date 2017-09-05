require 'pry'

module Hotel

  class Room
    attr_reader :id, :status, :nightly_rate

    def initialize(id_number, nightly_rate = 200)
      @id = id_number
      @status =  :available
      @nightly_rate =  nightly_rate
    end

  end

end

# binding.pry
