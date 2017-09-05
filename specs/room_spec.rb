#room_spec.rb
require_relative 'spec_helper.rb'
describe "The Room class" do

  describe "Initializing the room roster" do

    it "can be initialized" do
      @room_roster = Hotel_Chain::Room.new(5)
      @room_roster.class.must_be_kind_of Class
      @room_roster.room_id.must_equal 5
      @room_roster.room_id.must_be_kind_of Integer
      #@room_roster.rate.must_equal 200
      #@room_roster.rate.must_be_kind_of Integer
    end

  # describe "Self.all method" do
  #
  #   it "Room roster contains 20 room objects" do
  #     @room_roster = Hotel_Chain::Room.all
  #     @room_roster.length.must_equal 20
  #   end
  #
  #   it "Room roster must be instance of Hotel::Room" do
  #     @room_roster = Hotel_Chain::Room.all
  #     @room_roster[0].must_be_instance_of Hotel::Room
  #   end

    # it "Room roster is an array of room objects" do
    #   @room_roster = Hotel_Chain::Room.all
    #   @room_roster.must_be_kind_of Array
    # end
  # end

  end



end
