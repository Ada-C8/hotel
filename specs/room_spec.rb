#room_spec.rb
require_relative 'spec_helper.rb'
describe "The TileBag class" do

  before do
    @room_roster = Hotel::Room.new
  end

  describe "Initializing the room roster" do

    it "Room roster must be instance of Hotel::Room" do
      @room_roster.must_be_instance_of Hotel::Room
    end

    it "Room roster is a class of Hotel" do
      @room_roster.class.must_be_kind_of Array
    end

    it "Contains 20 room objects" do
      @room_roster.length.must_equal 20
    end

  end

  # describe "The TileBag class" do
  #
  #   before do
  #     @tilebag = Scrabble::TileBag.new
  #   end
  #
  #   describe "Initializing TileBag" do
  #
  #     it "Tilebag must be instance of Scrabble::TileBag" do
  #       @tilebag.must_be_instance_of Scrabble::TileBag
  #     end
  #
  #     it "Tilebag is a class of the Scrabble" do
  #       @tilebag.class.must_be_kind_of Class
  #     end

    end
