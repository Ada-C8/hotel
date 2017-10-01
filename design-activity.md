What classes does each implementation include? Are the lists the same?
  The classes for each implementation are the same. Both include CartEntry, ShoppingCart, and Order.

Write down a sentence to describe each class.
  Each instance of CartEntry has a unit price and a quantity of the unit being put in the cart. Each instance of ShoppingCart is a collection of CartEntry objects. Each instance of Order has an instance of ShoppingCart as an attribute and has the ability to calculate the total price of the cart.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  Order "has-a" ShoppingCart and ShoppingCart "has-a" CartEntry.

What data does each class store? How (if at all) does this differ between the two implementations?
  The way data is stored is the same between the two implementations. CartEntry has a unit price attribute and a quantity attribute. ShoppingCart has entries as an attribute, which is an array of CartEntry objects. Order has the SALES_TAX constant and an instance of cart as an attribute.

What methods does each class have? How (if at all) does this differ between the two implementations?
  Outside of the initialize methods, Implementation A only has one method: the total_price method in Order. This method is responsible for calculating the price of each CartEntry, summing the price of the ShoppingCart before tax, and adding tax to that subtotal.

  Implementation B splits this logic across the classes. CartEntry calculates its price, ShoppingCart calculates its price, and Order includes tax.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order? Does total_price directly manipulate the instance variables of other classes?
  In implementation A, al the logic is retained in Order, so total_price does have to directly access other classes' instance variables. In implementation B, the logic is delegated to "lower level" classes, so total_price does not interact directly with CartEntry or ShoppingCart's instance variables.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  Modifying Implementation B is really easy: all we would have to do is add a little conditional statement in CartEntry's price method to adjust the price if quantity is at or above a certain threshold. In this case, it seems as though Implementation A is also pretty easy to modify (throw a conditional inside the total_price method), but it doesn't really make 'real-life' sense that the quantity of each individual entry would change your method for calculating the total_price of the entire order. It makes more sense that the quantity of a single entry changes how you calculate the price of that entry.

Which implementation better adheres to the single responsibility principle?
  Implementation B!

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  Implementation B: in this implementation Order depends on the existence of ShoppingCart and it responding to .price. Implementation A's Order depends on the existence of ShoppingCart, SC responding to .entries, entry being an object that can respond to .unit_price AND entry being an object that can respond to .quantity.

Revisiting Hotel
  Classes: Hotel, Room, Reservation, Block
  What is each class' responsibility? Is it responsible for exactly one thing? Does this class take on responsibility that could be delegated to "lower level" classes? Is there code in other classes that directly manipulate's this class' instance variables?

    Hotel: creates and stores a collection of rooms, creates and stores blocks, and finds reservations. I would argue that storing rooms/blocks and finding reservations are strongly related enough that they count as a single responsibility: Hotel's responsibility is to allow you to interact with a group of rooms. Creating blocks does not seem like it can be delegated to a lower-level class because, as far as I can tell, that would require a class to have knowledge of its own instances, which is strange and would involve using scary class variables. I can't see of a way to get around a hard-coded reference to Room.new in Hotel either, since the number of rooms I'm creating varies according to number_of_rooms.

    Room: knows its own availability and creates reservations. To me, this is a single responsibility. Hotel depends on room being initialized with a room number argument and responding to .reservations and .reserve. I don't think creating reservations should be delegated to Reservation: the class would need knowledge of room.reservations, which isn't intuitive to me, and doesn't solve any problems.

    Reservation: stores pertinent information (check_in, check_out, room_number, rate_adjustor) and can calculate its own cost. This class definitely has a single responsibility. Knowing reservation info is 100% necessary for calculating cost, which is the only thing Reservation does. Room relies on Reservation being initialized with check_in and check_out as arguments. Room also relies on Reservation responding to .room.

    Block: knows all the same things reservation knows, in addition to which rooms are in it. Knows which rooms have been reserved and can reserve available rooms. This class also definitely has a single responsibility: the block being able to reserve rooms can't be separated from its knowing which of its rooms are already reserved. Hotel depends on Block being initialized with check_in, check_out, rooms, and rate_adjustor.

Activity

Refactoring Opportunity: I am happy with each class' responsibilities, but Hotel has a lot of dependencies and Room has a few, too. I don't think I can eliminate these dependencies, but I can isolate them. Room initially depended on Reservation responding to .check_in and .check_out. This dependency was buried in some fairly complicated logic. I refactored so that Reservation knows how to determine whether it includes a given date. Then I was able to pull out some of the .available? logic in Room, so that Room's new dependency on Reservation responding to .includes? is more isolated in the .find_res_by_date method. This turned out to be the same method I used in Hotel, so I pulled the method out into helpers.rb, so that both dependencies are now in one place. I also pulled rooms.available? out of create_block, so that dependency is more isolated.
