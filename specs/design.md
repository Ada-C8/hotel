WAVE 1
As an administrator, I can access the list of all of the rooms in the hotel
As an administrator, I can reserve a room for a given date range
As an administrator, I can access the list of reservations for a specific date
As an administrator, I can get the total cost for a given reservation

The hotel has 20 rooms, and they are numbered 1 through 20
Every room is identical, and a room always costs $200/night
The last day of a reservation is the checkout day, so the guest should not be charged for that night
For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)

WAVE 2
As an administrator, I can view a list of rooms that are not reserved for a given date range
As an administrator, I can reserve an available room for a given date range

A reservation is allowed start on the same day that another reservation for the same room ends
Your code should raise an exception when asked to reserve a room that is not available

WAVE 3
As an administrator, I can create a block of rooms
To create a block you need a date range, collection of rooms and a discounted room rate
The collection of rooms should only include rooms that are available for the given date range
If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block
As an administrator, I can check whether a given block has any rooms available
As an administrator, I can reserve a room from within a block of rooms
Constraints

A block can contain a maximum of 5 rooms
When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations

**Nouns:**
* administrator
* room(s)
* hotel
* date
* date range
* reservation(s)
* list (of rooms)
* list (of reservations)
* cost
* room number
* guest


**Verbs:**
* access (lists)
* reserve (room)
* get (cost)
