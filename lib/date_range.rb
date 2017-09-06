module DateRange
  def self.range(start_date, end_date)
    start_date = validate(start_date)
    end_date = validate(end_date)
  end

  # private

  def self.validate(input)
    return input if input.class == Date
    begin
      Date.parse(input)
    rescue
      raise TypeError.new("Invalid input #{input.class} - must be Date or String")
    end  
  end
end
