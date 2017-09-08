require 'date'


class Hotel
attr_accessor :rooms

def initialize
  @rooms = []

  id = 1
  20.times do
    @rooms << Room.new(id)
    id += 1
  end
end



end # end of class


# Be able to access a list of all 20 rooms - with just ID and cost? Does this need to be fleshed out more?
