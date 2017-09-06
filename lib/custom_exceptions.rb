#custom_exceptions.rb

class WrongDateFormatError < ArgumentError
  def initialize
    super ("lalala")
  end
end
