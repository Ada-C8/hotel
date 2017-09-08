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
      @california.all_rooms[1].create_reservation("2017-03-13", "2017-03-16")
      @california.all_rooms[5].create_reservation("2017-03-14", "2017-03-20")
      @california.all_reservations.length.must_equal 2
    end

    it "Raises an error if an invalid date is given" do
      proc { @california.all_rooms[1].create_reservation("2017-33-13", "2017-03-16").must_raise ArgumentError }
    end

    it "Raises an error if the room is already booked" do
      @california.all_rooms[1].create_reservation("2017-03-13", "2017-03-16")
      proc { @california.all_rooms[1].create_reservation("2017-03-13", "2017-03-16").must_raise ArgumentError }
    end

    it "Adds reservation if checking in when another reservation is checking out" do
      @california.all_rooms[1].create_reservation("2017-03-04", "2017-03-05")
      @california.all_rooms[1].create_reservation("2017-03-05", "2017-03-19")
      @california.all_rooms[1].create_reservation("2017-03-19", "2017-03-21")
      @california.all_rooms[1].reservations.length.must_equal 3
    end
  end

  describe "total method" do
    it "Returns the total cost for a given reservation" do
      @california.all_rooms[1].create_reservation("2017-03-13", "2017-03-14")
      @california.total(1).must_equal 200
    end
  end

  describe "find_by_date method" do
    it "Finds all reservations for a given date" do
      @california.all_rooms[1].create_reservation("2017-03-13", "2017-03-16")
      @california.all_rooms[5].create_reservation("2017-03-14", "2017-03-20")
      @california.find_by_date("2017-03-14").length.must_equal 2
      @california.find_by_date("2017-03-23").length.must_equal 0
      proc { @california.find_by_date("2017-43-23").must_raise ArgumentError }
    end
  end

  describe "all_rooms method" do
    it "Returns all rooms in Hotel California" do
      @rooms.must_be_instance_of Hash
      @rooms.length.must_equal 20
    end
  end

  describe "all_reservations method" do
    it "Returns all reservations in Hotel California" do
      @california.all_rooms[1].create_reservation("2017-03-13", "2017-03-16")
      @california.all_rooms[5].create_reservation("2017-04-10", "2017-04-27")
      @california.all_reservations.must_be_instance_of Array
      @california.all_reservations.length.must_equal 2
    end
  end

end
