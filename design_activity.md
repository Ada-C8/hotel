What classes does each implementation include? Are the lists the same?

Implementation A and B both contain classes with the same names, CartEntry, ShoppingCart, and Order, but the methods available to call on the class differ between the implementations of the CartEntry and ShoppingCart classes. The lists for those 2 methods differ in that Implementation B has a method called "price" in CartEntry and ShoppingCart class. Otherwise, the instance variables are the same and the instance methods for each class are also the same.

Write down a sentence to describe each class.

Implementation A

CartEntry sets the unit price and quantity. ShoppingCart initializes the empty array for order entries. Order creates a new instance of a shopping cart and calculates the total price after sales tax based on the unit price and number of entries in the @entries array.

Implementation B

CartEntry sets the unit price and quantity and sets price by returning the product of unit price and quantity. ShoppingCart initializes the empty array for order entries and sets price by using the price method in CartEntry based on the number of items in the @entries array. Order creates a new instance of a shopping cart and calculates the total after tax based on the price method.

How do the classes relate to each other?

 In Implementation B, ShoppingCart calls on the price method in CartEntry. The same action takes place in the Order total_price method, with Order calling self.price on the instance of ShoppingCart. In Implementation A the only class that calls on another method is Order, by calling the accessor methods in CartEntry and calling entries accessor method in total_price.

 What data does each class store? How (if at all) does this differ between the two implementations?

 CartEntry stores the unit_price and quantity. ShoppingCart stores the order entries. Order stores the instances of shopping carts and the price of the orders after tax is applied. The implementations differ in that Implementation B also stores how price is calculated in each class.

 What methods does each class have? How (if at all) does this differ between the two implementations?

 Implementation A - CartEntry has an initialize method, ShoppingCart has an initialize method, and Order has an initialize and total_price method. Implementation B - CartEntry has an initialize and price method, ShoppingCart has an initialize and price method, and Order has an initialize and total_price method. The difference between the 2 implementations is how price after tax is calculated. In Implementation B, the price is incrementally calculated in each price method and then the price method is called on in the total_price method, where as with Implementation A, the price is price after tax is calculated all in the total_price method.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Does total_price directly manipulate the instance variables of other classes?

In Implementation B, the logic is delegated to lower level classes ,in A it is contained in the total_price method in the Order class. Total_price directly manipulates the instance variables in the Implementation A, when it accesses the unit_price and quantity in the CartEntry class.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

Implementation B would be easier to modify. The code in CartEntry#initialize could be changed with the unit_price instance variable that sets a lower price if a certain quantity is requested. In Implementation A, it'd probably be necessary to also change the total_cost method since it is calling on both the quantity and unit_price instance variables directly. There wouldn't be a need to change the total_cost method in B since it doesn't call on those variables in that method.

Which implementation better adheres to the single responsibility principle?

Implementation B, because the logic is delegated to the lower level classes by using the price method. The total_price method in Implementation A seems like it would be considered to be responsible for all the behavior surrounding calculating price, where in Implementation B, the responsibility is placed throughout the lower level classes. 
