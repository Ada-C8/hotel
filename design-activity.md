**What classes does each implementation include? Are the lists the same?**

   CartEntry, ShoppingCart, and Order. Yes both implementations have the same Classes.

**Write down a sentence to describe each class**

   * CartEntry: Contains information on pricing per unit and the quantity for each entry
   * ShoppingCart: Contains a list of CartEntries
   * Order: An Order that contains an instance of ShoppingCart and all its CartEntries

**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper**

   An Order initializes a new ShoppingCart. In the ShoppingCart, there are CartEntries. Each CartEntry has a unit price and a quantity.

**What data does each class store?**

   CartEntry stores integers, ShoppingCart stores an array of instances of CartEntries and the Order stores an instance of ShoppingCart with all of it's CartEntries.

   **How (if at all) does this differ between the two implementations?**

   These do not differ between the two implementations but what does differ is the instance methods that are available for each of these Classes.

**What methods does each class have? How (if at all) does this differ between the two implementations?**

   CartEntry, ShoppingCart, and Order has a price/total_price instance methods in implementation B whereas Order#total_price is the only instance method available in implementation A.

__Consider the Order#total_price method. In each implementation:__

   * __Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?__

   In A, Order#total_price is calculating the price of the cart entries and then adding the sales tax. In B, the Order#total_price is calling the instance method of price on ShoppingCart instead of calculating the price of the ShoppingCart inside the Order class.

   * __Does total_price directly manipulate the instance variables of other classes?__

   In method A, total_price is iterating over each entry to calculate the total.


**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**

   Implementation B is easier to modify. If items were cheaper in bulk, when a new CartEntry instance is created, I would put in a unit_price and quantity for that bulk item. Because the responsibilities. A new method or class does not need to be created even if it is a bulk item.

**Which implementation better adheres to the single responsibility principle?**

   Implementation B

**Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**

   Implementation B

## REVISITING HOTEL

One place in my hotel class that that can be loosely coupled is the reserve_room_in_block method. I can create a new method inside the Block class to be able to reserve the number of requested rooms in the block so that the reserve_room_in_block method can just reserve the rooms requested. This allows the Hotel to ONLY reserve a room in the block and allows the Block to ONLY manipulate its own instance variables directly.

Another method that I separated is the valid_dates? method. This was moved from the hotel to the date_range class as this functionality is the responsibility for the date class and not the hotel class.

I also moved the update rooms in block method as a private method as this should automatically be updated once the reserve_rooms method is ran.
