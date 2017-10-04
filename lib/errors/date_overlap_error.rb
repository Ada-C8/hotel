class DateOverlapError < StandardError
  def initialize(msg="Date range overlaps with an existing (block) reservation")
    super
  end
end
