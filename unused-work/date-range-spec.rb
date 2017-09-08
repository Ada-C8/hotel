it "include? method returns True" do
  # Boundry cases
  date = Date.new(2017,2,3)
  @date_range.include?(date).must_equal true

  date = Date.new(2017,2, 6)
  @date_range.include?(date).must_equal true

  # edge cases
  date = Date.new(2017,2, 2)
  @date_range.include?(date).must_equal false

  date = Date.new(2017,2,7)
  @date_range.include?(date).must_equal false


end
