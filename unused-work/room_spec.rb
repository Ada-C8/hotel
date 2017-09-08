require_relative '../specs/spec_helper'

=begin


- Room class makes ojects of room.
- Its attributes are:
- room number: each room must be 1-20

The hotel has 20 rooms, and they are numbered 1 through 20
- Every room is identical, and a room always costs $200/night
- The last day of a reservation is the checkout day, so the guest should not be charged for that night
- For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)
- Your code should raise an error when an invalid date range is provided
- A reservation is allowed start on the same day that another reservation for the same room ends
- Your code should raise an exception when asked to reserve a room that is not available


- Each room should have a room number.
- pass in the room number to the room object.
- to automate making all 20 rooms we need a times loop from 1-20.
- set an iterative variable to 1.
- errors for room numbers not on the sequence 1-20
- errors for reservation status not being either "reserved" or "vacant"


=end

describe "Room Class" do
  before do
    @room = Hotel::Room
  end

  describe "initialize" do
    # it "Takes strings for both room number and reservation status" do
    #   room_num = "1"
    #   reservation_status = "Reserved"
    #
    #   room_num.must_be_instance_of String
    #   reservation_status.must_be_instance_of String
    #
    # end
    #
    # it "Raises an error for room number not being in range 1 -20" do
    #   room_num = "#"
    #   reservation_status = "Reserved"
    #   proc {
    #     Hotel::Room.new(room_num, reservation_status)
    #   }.must_raise ArgumentError
    #
    #   room_num = "21"
    #   proc{
    #     @room.new(room_num, reservation_status)
    #   }.must_raise ArgumentError
    # end
    #
    # it "Raises an error for reservation status not being either 'Reserved' or 'vacant'" do
    #   room_num = "20"
    #   reservation_status = "Rainbow"
    #
    #   proc {
    #     @room.new(room_num, reservation_status)
    #   }.must_raise ArgumentError
    #
    #   reservation_status = "123"
    #   proc {
    #     @room.new(room_num, reservation_status)
    #   }.must_raise ArgumentError
    #
    #   reservation_status = "!@#"
    #   proc{
    #     @room.new(room_num, reservation_status)
    #   }.must_raise ArgumentError
    #
    # end

    it "Returns an instance of Room class" do
      room_num = "1"
      reservation_status = "Reserved"

      @room.new(room_num, reservation_status).must_be_instance_of Hotel::Room

    end
  end # end initialize

end # end room class
