class DateRangeInvalidError < StandardError
  def initialize(msg="Date range given is invalid")
    super
  end
end
