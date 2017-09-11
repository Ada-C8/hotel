module BookingSystem
  class Guest

    attr_reader :first_name, :last_name

    def initialize(first_name, last_name)
      raise ArgumentError.new("first name must be a string") if !first_name.is_a? String
      @first_name = first_name

      raise ArgumentError.new("last name must be a string") if !last_name.is_a? String
      @last_name = last_name
    end

  end#of_Guest_class
end#of_module_BookingSystem
