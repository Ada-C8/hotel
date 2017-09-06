require_relative 'spec_helper'

describe "My_Hotel::Hotel" do
  describe "initialize" do
    it "creates an instance of Hotel" do
      hotel_california = My_Hotel::Hotel.new
      hotel_california.must_be_kind_of My_Hotel::Hotel

      hotel_california.rooms.must_be_kind_of Hash
      hotel_california.rooms.length.must_equal 20

      # must be able to access .list_of_reservations

    end
  end

  # describe "display_rooms"
  # it "must puts out a list of all the rooms" do
  #   #TODO: Test
  # end
  #
  #
  # describe "display_reservations" do
  #   it "must put out a list of all the reservations" do
  #     #TODO: Test
  #   end
  # end
  #
  #
  # describe "rooms_available_date" do
  #   it "must return a list of availble rooms" do
  #     #TODO: Test - List == array?
  #     #- List == correct list
  #     # rejects bad dates
  #   end
  # end
  #
  # describe "rooms_available_block" do
  #   it "must return a list of availble rooms in a block" do
  #     #TODO: Test - List == array?
  #     #- List == correct list
  #     # rejects bad dates
  #     #rejects bad block ids
  #   end
  # end
  #
  # describe "make block" do
  #   it "must allow the admin to assign a block_id to rooms" do
  #     #TODO: test
  #   end
  # end



end
