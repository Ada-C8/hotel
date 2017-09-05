require_relative 'spec_helper'

describe "Room class" do

it "Can be instantiated" do
  Hotel::Room.new.must_be_instance_of Hotel::Room 
end

end #describe
