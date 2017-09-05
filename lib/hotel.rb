module Hotel_System

class Hotel

  attr_reader :all_rooms

  def initialize(num_of_rooms)
    @all_rooms = Array.new(num_of_rooms)
  end

end

end
