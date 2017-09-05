require_relative 'spec_helper'

describe 'Hotel' do

    describe "initialize" do
      it "creates a new instance of hotel" do
        Hotel.new.must_be_instance_of Hotel
        # proc {Scrabble::Player.new(1)}.must_raise ArgumentError
      end
    end
      # it "holds a name" do
      #   @player.name.must_equal "Ada"
      # end
end
