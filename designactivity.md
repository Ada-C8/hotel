
    1. What classes does each implementation include? Are the lists the same?

   The classes are the same for both implementations: CartEntry, ShoppingCart, and Order.


    2. Write down a sentence to describe each class.

   Implementation A:
     * The CartEntry class tracks the quantity and price of an item in a shopping cart.
     * The ShoppingCart stores objects of the CartEntry class.
     * The Order class initializes with a ShoppingCart instance and calculates the total price with sales tax for the cart.

   Implementation B:
     * The CartEntry class calculates the price of an entry (unit price * quantity).
     * The ShoppingCart class calculates the price of all entries together.
     * The Order class calculates the total price (cart price + sales tax).

    3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

   In Implementation A, the CartEntry and ShoppingCart classes store data needed to calculate the order, while the Order class uses the data to calculate the order total.

   Implementation B, the CartEntry and ShoppingCart classes calculate the price of their respective components, and the Order class uses the cart price method to calculate the order total.

    4. What data does each class store? How (if at all) does this differ between the two implementations?

   In both implementations, the CartEntry class stores its item's price and the quantity ordered, the ShoppingCart class stores an array of cart entry objects, and the Order class stores the sales tax rate (as a constant) and an instance of a ShoppingCart.

    5. What methods does each class have? How (if at all) does this differ between the two implementations?
   In implementation A, the CartEntry class has attribute accessor methods for the instance variables unit_price and quantity. The ShoppingCart class has an attribute accessor method for the instance variable entries. The Order class has a method for total_price.

   In implementation B, the CartyEntry class and the ShoppingCart class both have a price method, and the Order class has a total_price method.

    6. Consider the Order#total_price method. In each implementation:
  * Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

  * Does total_price directly manipulate the instance variables of other classes?

   In implementation A, all of the logic for calculating the total price is contained in the total_price method, which directly manipulates the ShoppingCart instance variable, and reads the instance variables of each CartEntry object.

   In implementation B, CartEntry objects each calculate their own price, and the ShoppingCart object can calculate the sum of all its entries. The Order total_price method calls the price method on a ShoppingCart object but does not directly access or manipulate any instance variables from the other classes.

    7. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

   In implementation A, the instance variable unit_price is read by the Order total_price method, so to avoid changing that call, you could create a unit_price method in the CartEntry class. The unit_price method could use a case when to return a bulk unit price based on the quantity. Then you would change the initialize method to accept base_price as a parameter, change the instance variable to "@base_price", remove :unit_price from the accessor list. This way a base price would be set when the item was created, but need not be directly accessed by the Order class.

   In implementation B, you could similarly define a unit_price method for CartEntry that uses a case statement and the quantity to return a discounted unit price based on each bulk discount level. Then in the price method you call the unit_price method instead of the unit_price instance variable. Because the price method is the only public method of CartEntry that is currently used in our program, no further changes are needed in other classes.

   Implementation A is somewhat harder to change, even though the added feature looks fairly similar. The extra effort is spent abstracting the unit price from the Order class. In System A, the Order class knows that an entry has a unit_price and a quantity, so if the unit price can change the Order class will need to know how to accurately calculate the cart subtotal. To avoid having the Order class directly check and possibly change the unit price each time total_price is called, the CartEntry class instance variable is changed and access to it is removed so that the Order class can call the method unit_price on an entry, and receive the correctly discounted unit price, without having to know any business logic surrounding unit price.


    8. Which implementation better adheres to the single responsibility principle?

   Implementation B: The CartEntry class is responsible for knowing the price of any number of a single item. The ShoppingCart class is responsible for knowing the combined price of all its CartEntry objects. The Order class is responsible for knowing the total price of the ShoppingCart object, which in this case includes applying a sales tax (but could also include other costs like shipping).

   By contrast, Implementation A uses two of its classes solely for data storage (unit price and quantity, and a collection of cart entries) without any behavior. Instead the Order class must calculate the total price of each cart entry, add those prices together, then calculate and return the total order price.

    9. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

   Implementation B is more loosely coupled: because each class protects its instance variables and only knows the minimum of what is needed to fulfill its responsibility. Both ShoppingCart and CartEntry provide the calculated price of its contents through a public method, without allowing direct access to their instance variables. A ShoppingCart instance only has to know that an entry has a price, and an Order instance only has to know that a cart has a price. An Order only knows that calling .price on a ShoppingCart instance will return a number to which sales tax can be applied. You could pass Order any object that responds to a method call for .price and be able to provide a total.


For each class in your program, ask yourself the following questions:

Hotel
  What is this class's responsibility? You should be able to describe it in a single sentence.

  This class makes reservations.

  Is this class responsible for exactly one thing?

  Yes, but in order to accomplish that one thing it has many methods for checking room availability

  Does this class take on any responsibility that should be delegated to "lower level" classes?

  Passing around a bunch of date objects (checkin and checkout) is kind of clunky. It might be better if the Room class could determine whether it is booked or not for a given date or date range.

  Is there code in other classes that directly manipulates this class's instance variables?

  No

Reservation
  What is this class's responsibility? You should be able to describe it in a single sentence.

  This class validates check-in and checkout-dates, and knows the cost of stay.

  Is this class responsible for exactly one thing?

  Technically no, it includes a validation method that is called during initialize to verify the date inputs, and it also knows how much the stay will cost.

  Does this class take on any responsibility that should be delegated to "lower level" classes?

  It makes sense to me to validate the input here--the way it is set up you can only create a new reservation through the Hotel class, so you would want to return an error here, rather than give the responsibility to the Hotel class.

  If instead I had implemented a DateRange class, it would probably make sense to delegate validation to that class.

  Is there code in other classes that directly manipulates this class's instance variables?

  Yes, in the Hotel class there is a method new_reservation which creates a new instance of Reservation, passing its arguments as the instance variables. In this way, the Hotel class is acting as a controller, and the Reservation class is a model.

Block
  What is this class's responsibility? You should be able to describe it in a single sentence.

  As a subclass of Reservation, this class has the same responsibilities, except that it also takes a discount argument and calculates its cost with the given discount.

  Is this class responsible for exactly one thing?

  Same for the parent class, this class has two responsibilities: to validate date inputs and know the cost of the room for the length of the stay.

  Does this class take on any responsibility that should be delegated to "lower level" classes?

  Same as above, if there were a DateRange class the validation would be delegated there.

  Is there code in other classes that directly manipulates this class's instance variables?

  Yes, the Hotel class has a new_block method and a reserve_from_block method that both create a new instance of a Block object, passing its arguments for the instance variables.

Room
  What is this class's responsibility? You should be able to describe it in a single sentence.

  This class has no responsibility--currently the Room objects exist to provide a room number to the other classes.

  Is this class responsible for exactly one thing?

  It is currently responsible for nothing except knowing its own existence. I would have removed it as a class entirely but it seemed more likely than not you would eventually want to track more information for the rooms, and setting it up as a class didn't seem any more costly than simply keeping a list of rooms.

  Does this class take on any responsibility that should be delegated to "lower level" classes?

  No, if anything it should take on some responsibility.

  Is there code in other classes that directly manipulates this class's instance variables?

  Yes, when a Hotel object is initialized, it creates the specified number of Room objects, with their room number.

Activity

Based on the answers to the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how why the resulting design would be an improvement.

When I re-opened my Hotel project many of my tests were failing. I was not able to take the time to figure out why and make any changes to my code. As it is, I'm not sure how I would have been able to change the code. Adding a DateRange class didn't really seem to take any responsibility away from the Hotel class, or at least, not enough that it was worth making the changes. 
