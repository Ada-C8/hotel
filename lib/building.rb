
require_relative 'room'

module Hotel

  class Building
    attr_reader :rooms

    def initialize
      @rooms = []

      20.times do |num|
        @rooms << Hotel::Room.new(num + 1)
      end
    end

  end # Building class

end # Hotel module
