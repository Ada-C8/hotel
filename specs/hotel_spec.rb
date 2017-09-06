require_relative "spec_helper"

describe "California class" do
  before do
    @california = Hotel::California.new
    @rooms = @california.all_rooms
    @reservations = @california.all_reservations
  end

  describe "initialize" do
    it "Creates an instance" do
      @california.must_be_kind_of Hotel::California
    end

    it "Can access rooms & reservations" do
      @rooms.must_be_instance_of Hash
      @rooms.length.must_equal 20
      @reservations.must_be_instance_of Array
    end
  end

  describe "create_reservation method" do
    it "Creates reservation objects" do
      @california.create_reservation("2017-03-13", "2017-03-16")
      @california.create_reservation("2017-04-10", "2017-04-27")
      @reservations.length.must_equal 2
      @reservations[0].dates.length.must_equal 4
    end

    it "Raises an error if an invalid date is given" do
      proc { @california.create_reservation("2017-23-13", "2017-03-16").must_raise ArgumentError }
    end
  end

  describe "total method" do
    it "Returns the total cost for a given reservation" do
      @california.create_reservation("2017-03-13", "2017-03-16")
      @california.total(1).must_equal 600
    end
  end

  describe "find_by_date method" do
    it "Finds all reservations for a given date" do
      @california.create_reservation("2017-03-13", "2017-03-16")
      @california.create_reservation("2017-03-14", "2017-03-20")
      @california.find_by_date("2017-03-13").length.must_equal 1
      @california.find_by_date("2017-03-14").length.must_equal 2
      @california.find_by_date("2017-03-23").length.must_equal 0
    end
  end

  describe "all_rooms method" do
    it "Returns all rooms in Hotel California" do
      @rooms.length.must_equal 20
    end
  end

  describe "all_reservations method" do
    it "Returns all reservations in Hotel California" do
      @california.create_reservation("2017-03-13", "2017-03-16")
      @california.create_reservation("2017-04-10", "2017-04-27")
      @reservations.must_be_instance_of Array
      @reservations.length.must_equal 2
    end
  end

end
