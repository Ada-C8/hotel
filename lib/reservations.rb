require_relative 'availability'
require 'date'

# A reservation takes an individual instance of a room object and changes its status for the future, and also outputs cost-related information



# Have a list of all reservations method
  # Should this list all upcoming reservations?  Or all reservations ever?
  # Shovel all reservations ever into a hash which will output by default
  # Keyword argument lets you access reservations by date if you want


# Reservation method
  # Needs a room number and a date range (start with one date and build to range from there)
  # Checks if room is available first
  # Tells you that it can't be booked if it's status is not :available
  # If it is available, changes its status to :booked for each night of the stay (but does not change status to booked for last date)
  # Outputs details as a hash: room, length of stay (x nights), date of checkout (last day of reservation), and cost  of reservation
