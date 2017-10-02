Q: What classes does each implementation include? Are the lists the same?

A: Both implementation have the same classes names, but classes itself are different. Those classes are:
    * CartEntry
    * ShoppingCArt
    * Order

Q: Write down a sentence to describe each class.

A:  
  * Implementation A - CartEntry: It initializes one product that have two instances variables quantity and unit_price.

  * Implementation B - CartEntry: It initialize a product with two instances variables, unit_price and quantity. It calculates the total price of the product.

  * Implementation A -  ShoppingCart: It creates an empty array to place all the products.

  * B - ShoppingCart: It initializes an empty array to place all the products and calculate the total price for all products without taxes.

  * A - Order: It creates a new instance of ShoppingCart. It calculates the total price per product and  it sums the total price for all products including taxes.

  * B - Order: Creates a new instance of ShoppingCart and add the taxes to the total price.

Q: How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

A: Implementation A: The Order class uses CartEntry and ShoppingCart classes. It creates a new instance of ShoppingCart that is call cart. For each element in cart calculate the total price, using the instance variables of the CartEntry class. Sum all this result and add the taxes.

Implementation B: CartEntry calculates the price per entry, the ShoppingCart uses this prices to calculate the total price of all products without taxes. Finally Order class creates an instance of ShoppingCart, it adds the taxes to the total price (calculates in ShoppingCart). This way ShoppingCart is relate to CartEntry and Order is relate to ShoppingCart.

Q: What data does each class store? How (if at all) does this differ between the two implementations.

A: CartEntry stores unit_price and quantity, ShoppingCart stores entries, Order stores cart that is an instance of ShoppingCart and sales tax. The classes in both implementations store the same data.

Q: What methods does each class have? How (if at all) does this differ between the two implementations?

A:
* CartEntry has the same  initialize method in both implementations. In implementation B, there is also a price method that multiplies unit_price by quantity returning the total price per product.

* ShoppingCart has the same initialize method in both implementations. In implementation B there is a price method that returns the sum of the total value for each element in the entries array.

* Order class has the same initialize method in both implementations. The implementation A has a total_price method that calculates the total price per product in cart and add all this values. Later it adds the sales taxes to get the total price. In the implementation B total_price calls the price method from the ShoppingCart class to calculate the total value without taxes, then returns the total value of the order with taxes.  

Q: Consider the Order#total_price method. In each implementation:

Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

A: It is better to have price in lower level classes because otherwise all the logic is going to be store at the Order Class and this is not following the single responsibility principle.

Does total_price directly manipulate the instance variables of other classes?

A: In implementation A it manipulates unit_price and quantity from CartEntry class. It also iterates over the entries arrays from ShoppingCart class.

Implementation B doesn't manipulate directly the instance variables of other classes.

Q: If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

We need to have some code that checks if for a given quantity of a product we can apply the discount, this should be inside the CartEntry class.

It is easier to change the implementation B because we just need to change the CartEntry class, at the other hand with the implementation A we need to change CartEntry class and the method total_price inside Order class.

Q: Which implementation better adheres to the single responsibility principle?

A: The implementation B, because CartEntry takes care just for single products, ShoppingCart takes care of products inside entries and Order takes care of the order in general. While in implementation A, Order takes care of the single products, items in entries and the order in general.

Revisiting Hotel

When I did hotel the first time I paid special attention to the single responsibility of a class. Now that I'm looking  again this project, I think that the DateRange, Block and Reservation classes satisfies the requirements of a good design.

The Admin class is a big class that manages the reservations and store the information about the rooms. I wanted to crate a new class call Rooms. This class would create the hash with rooms using the create_rooms method. But when I was making the changes, I noticed that if I do this, then Admin class would modify the instance variables of Rooms class, so I decided not to modify Admin class. 

The change that I did was to put attr_reader or attr_accessor to instance variables, how Metiz books recommends.
