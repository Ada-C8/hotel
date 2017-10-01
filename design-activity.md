## What classes does each implementation include? Are the lists the same?
Implementations A and B include same three classes: CartEntry, ShoppingCart, Order.

## Write down a sentence to describe each class.
Class CartEntry stores the information about product and its price. It is responsible for the price for each particular product.
Class ShoppingCart contains all products (several cart entries).
Class Order creates new instance of class ShoppingCart and is responsible for the final price of the whole order include taxes.

## How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
Class Order is depends on the ShoppingCart class which is closely related to CartEntry class. Every time customer pick a new product(cart entry), it is getting stored to the instance of class ShoppingCar which is initialized in class Order.

## What data does each class store? How (if at all) does this differ between the two implementations?
Class CartEntry stores price for product(unit_price) and quantity.
Class ShoppingCart stores all products that customer picked.
Class Order stores the total price for the order.
The difference between two implementations is that in implementation A all calculation logic is in Order class whereas in implementation B it is located in each class (CartEntry, ShoppingCart) where it belongs.

##What methods does each class have? How (if at all) does this differ between the two implementations?
Class CartEntry has methods: initialize(A), and initialize and price(B). The difference between the two implementations is that in implementation B unit_price and quantity can't be accessed from the outside of class and instead it has a price method.
Class ShoppingCart has a similar difference between two implementations. In implementation A it has only one method initialize and can be accessed from outside of class. In implementation B private data is encapsulated.
Class Order in both implementations has two methods: initialize and total_price. The only difference is how it accesses data from two other classes. In implementation A, it uses data from CartEntry and ShoppingCart classes and calculates total_price, whereas in implementation B, it uses methods of these classes.

##Consider the Order#total_price method. In each implementation: is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In implementation A #total_price method is completely retained in Order. In implementation B it delegated to "lower level" classes by having #price methods in them.

##Does total_price directly manipulate the instance variables of other classes?
In implementation A #total_price method directly manipulates the instance variables of "lower level" classes such as entries, unit_price and quantity.

##If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
The implementation B is easier to modify because each class has a single responsibility. To add a discount for items in bulk I would add it to #price method of CartEntry class.

##Which implementation better adheres to the single responsibility principle?
The implementation B is better adheres to the single responsibility principle. Each class has a certain logic calculations and can be describe in one sentence.

##Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
The implementation B is more loosely coupled. The private data of classes is encapsulated and classes do not know much about each other.

##My improvements:

To improve design in Hotel project I added new method #reserve_room to class Block and changed method #make_reservation_from_block in class Hotel. It made my classes Hotel and Block more loosely coupled. In my new implementation the Hotel class knows less information about the Block class. This change did not break any of my tests but I still refactored them a little to check some new functionality. 
