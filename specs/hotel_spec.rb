require_relative '../specs/spec_helper'

=begin
Each room should have a room number.
- pass in the room number to the room object.
- to automate making all 20 rooms we need a times loop from 1-20.
- set an iterative variable to 1.
=end


it "Takes strings for both room number and reservation status" do
  room_num = "1"
  reservation_status = "Reserved"

  room_num.must_be_instance_of String
  reservation_status.must_be_instance_of String

end

it "Raises an error for room number not being in range 1 -20" do
  room_num = "#"
  reservation_status = "Reserved"
  proc {
    Hotel::Room.new(room_num, reservation_status)
  }.must_raise ArgumentError

  room_num = "21"
  proc{
    @room.new(room_num, reservation_status)
  }.must_raise ArgumentError
end

it "Raises an error for reservation status not being either 'Reserved' or 'vacant'." do
  room_num = "20"
  reservation_status = "Rainbow"

  proc {
    @room.new(room_num, reservation_status)
  }.must_raise ArgumentError

  reservation_status = "123"
  proc {
    @room.new(room_num, reservation_status)
  }.must_raise ArgumentError

  reservation_status = "!@#"
  proc{
    @room.new(room_num, reservation_status)
  }.must_raise ArgumentError

end
