What classes does each implementation include? Are the lists the same?

Implementation A & B includes the following classes:
  CartEntry
  ShoppingCart
  Order

Write down a sentence to describe each class.
implementation A:
  Class CartEntry stores the unit price and quantity of an item

  ShoppingCart stores the collection of all the items

  Order creates a new ShoppingCart and calculates the subtotal and total price for the items.

  Implementation B:
  CartEntry stores the unit price and quantity of an item and calculates the price for each item.

  ShoppingCart stores the collection of all the items and calculates the subtotal of all the items.

  Order creates a new ShoppingCart and calculates the total price of all the items by taking the subtotal from the ShoppingCart class and adding a sales tax.


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

What data does each class store? How (if at all) does this differ between the two implementations?
Implementation A
  CartEntry class stores unit price and quantity

  ShoppingCart class stores an array of all the cart entry items

  Order class stores the sales tax (constant) and shopping cart object.

  Implementation B
  CartEntry stores the unit price and quantity

  ShoppingCart stores an array of the cart entry items

  Order stores sales tax (constant) and shopping cart object.

  Both implementations are the same with regards to what is stored in each class.


What methods does each class have? How (if at all) does this differ between the two implementations?
  Implementation A
  CartEntry - initialize method
  ShoppingCart - initialize method
  Order - Initialize method and total price method

  Implementation B
  CartEntry - Initialize method and price method
  ShoppingCart - Initialize method and price method
  Order - Initialize and total price method

  In Implementation B, CartEntry and ShoppingCart each has an additional method that calculates price.


Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  Implementation A
  Logic to compute price is retained in Order.  

  Implementation B
  Logic to compute price is delegated to the CartEntry and ShoppingCart classes.  Order only requires the subtotal when a ShoppingCart object is created to calculate the total price with tax.

Does total_price directly manipulate the instance variables of other classes?
  No, it doesn't but in Implementation A, the Order class has access to the instances variables in the CartEntry and ShoppingCart classes.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  Implementation B
    BULK_QUANTITY = 100
    DISCOUNT = 0.1

    def price
      if @quantity >= BULK_QUANTITY
        return @unit_price * @quantity * (1.0 - DISCOUNT)
      else
        return @unit_price * @quantity
      end
    end

  Implementation B is a better option because only CartEntry will need to be modified without causing major changes downstream.

  In Implementation A, the discount price and bulk quantity will need to added to the Order class.

Which implementation better adheres to the single responsibility principle?
  Implementation B, each class is responsible for it's own behavior and state.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  Implementation B.  According to Sandi Metz, the more one class knows about another, the more tightly it is coupled (as seen in Implementation A).

  In Implementation A, Order class knows the order of CartEntry's arguments (i.e unit price & quantity)
  Order class has access to CartEntry's unit price & quantity due to the attr_reader.  Order class knows the name of another class i.e cart = ShoppingCart.new as well as CartEntry (I made the assumption that entry is an instance of CartEntry)

  In Implementation B, there is no attr_reader and each class has its own specific responsibility.

Once you've responded to the prompts, git add design-activity.md and git commit!


HOTEL ACTIVITY

It seems that most of my classes are loosely coupled but there is opportunity to refactor the booking system.

In the BookingSystem class, (lines 41 and 54), it will be better to create a new method for reservation date range in reservation class and call it in print reservation and room available methods.

Check the date_range in the reservation class instead of calling the method directly in the booking system class.  Furthermore, I can remove date_range from the attribute reader in the reservation class (I tried this and it is not true!).

After transferring the responsibility of checking if a reservation date overlaps to the reservation class, I am not so sure it was necessary.  It seems to make more sense to me initially the way it was designed.  That is, check if a reservation check is available then book.  Thoughts please.  
