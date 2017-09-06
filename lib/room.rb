#room
require 'awesome_print'

module HotelManagment
  class Room
    attr_reader :rooms, :id, :rate, :status

    def initialize(id,status)
      @id = id
      @rate = 200
      @status = status
    end
  end #class end
end #module end
