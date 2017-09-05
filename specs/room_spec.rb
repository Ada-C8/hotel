#room_spec.rb
require_relative 'spec_helper.rb'
describe "The Room class" do

  describe "Initializing the room roster" do

    it "can be initialized" do
      @room_roster = Hotel_Chain::Room.new(5)
      @room_roster.class.must_be_kind_of Class
      @room_roster.room_id.must_equal 5
      @room_roster.room_id.must_be_kind_of Integer
      @room_roster.rate.must_equal 200
      @room_roster.rate.must_be_kind_of Integer
    end

  end

end
