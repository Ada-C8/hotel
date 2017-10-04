class InvalidObjectPassedError < StandardError
  def initialize(msg="Invalid object passed into method")
    super
  end
end
