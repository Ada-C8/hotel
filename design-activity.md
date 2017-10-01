# Hotel Revisited

## Prompts: Responses

* What classes does each implementation include? Are the lists the same?

While both implementations A & B have the following classes: CartEntry, ShoppingCart, their list of classes are not the same. Implementation A's CartEntry class uses attr accessors for its unit_price and quantity, so its Order class can access those values when calculating the total price for each entry in the cart. Implementation B on the other hand does not use attr accessors and instead, has a price calculation method for each class such that: CartEntry has a price method to calculate each price per cart entry, the ShoppingCart has a price method to sum all cart entries in the cart (subtotal), and Order has a total_price method that adds SALES_TAX to the ShoppingCart's subtotal.

* Write down a sentence to describe each class.
  * CartEntry defines the state (unit_price and quantity) and behavior (price in implementation B) of each cart entry requested.
  * ShoppingCart defines the ShoppingCart object that's initialized as an array to store cart entries for one order.
  * Order creates an order (initialized as an instance of a ShoppingCart) and handles total_price calculation (using the SALES_TAX).

* How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

The classes relate to each in that an instance of an Order is made up of an instance of a ShoppingCart (called cart), where the cart is an array that stores any number of CartEntry instances.

* What data does each class store? How (if at all) does this differ between the two implementations?
* What methods does each class have? How (if at all) does this differ between the two implementations?

  * Implementation A:
  CartEntry: unit_price and quantity (with attr accessors)
  ShoppingCart: entries (array - with attr accessors)
  Order: SALES_TAX, total_price method

  * Implementation B:
  CartEntry: unit_price, quantity, CartEntry price method
  ShoppingCart: entries (array - no attr accessors), ShoppingCart subtotal price method
  Order: SALES_TAX, total_price method

  * Differences:
  - Implementation A delegates all price calculation to the Order class, while B has some level of price calculated within each class.
  - Implementation A makes use of attr accessors (interestingly rather than attr readers) and only uses one pricing method (total_price) in the Order class. Conversely, B does not us any attr accessors (I'm assuming to limit users ability to manipulate CartEntry data) and implements a price method for both CartEntry and ShoppingCart to access each objects' prices.

* Consider the Order#total_price method. In each implementation:
  * Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  A does not delegate the price computation responsibility to "lower level" classes; it is all retained in Order. B does delegate price computation to ShoppingCart and CartEntry so that its Order class only deals with adding the SALES_TAX to the ShoppingCart price.

  * Does total_price directly manipulate the instance variables of other classes?
  A's total_price directly references the instance variables for the ShoppingCart (entries) and CartEntry (unit_price and quantity), but it takes their values and stores it in the variable sum. So in that way, while it is not directly changing the variables, there is potential to manipulate them because they are being accessed using attr accessors. B only references the ShoppingCart price (using the price method), so this implementation does not directly manipulate any instance variables.

* If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

Implementation B would be easier to change because you could add additional code in CartEntry to account for cheaper cost when buying items in bulk.

* Which implementation better adheres to the single responsibility principle?

Implementation B appears to better adhere to the single responsibility principle because its classes (particularly Order and its total_price method) have less dependencies on its other classes. For example, it doesn't know/reference nearly as many objects and instance variables as A does in its total_price method. This is ideal because it reduces the potential for bugs and makes the code more adaptable.

Furthermore, before considering how we'd modify the code to consider bulk items, I thought A good in that it appeared DRY because it was consolidating and delegating all price calculations in Order (so you could just update price calculations all in one place), but now that I've had to also consider buying items in bulk and potential areas of price changes, it makes sense to break up the price calculation responsibilities.

* Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Implementation B is more loosely coupled because its Order class does not reference and knows less about the other classes (e.g. it doesn't reference any CartEntry objects like A).


## Revisiting Hotel Activity:

HotelAdmin is currently tightly coupled with my block and reservation classes. For example, I had date validation for reservations made in both my HotelAdmin and Reservation. I've changed it so now only my Reservation class handles date validation. Previously, I'd also planned for the HotelAdmin class to check if a block would conflict with an existing reservation before attempting to create the block. To decouple this area of logic, now the HotelAdmin class just creates a block while the block class performs the validation to decide if there is a conflict with an existing reservation.























########
