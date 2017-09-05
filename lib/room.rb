module Hotel

class Room
#attr
attr_reader :number, :rate

#constants
#TODO 2. decide on ROOM_RATE constant?

#initialize
  def initialize(number)
    @number = number
    @rate = 200
  end
#class methods

#instance methods


end # Room class

##TODO 3. decide if this is the right area to contain room instantiation, or if it should be within another object such as hotel, or just in another file under the module Hotel



end # Hotel module
