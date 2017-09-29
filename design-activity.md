What classes does each implementation include? Are the lists the same?

Implementation A and Implementation B both include the same classes:
- CartEntry
- ShoppingCart
- Order


Write down a sentence to describe each class.

Implementation A:
CartEntry - holds the price and quantity of one entry
ShoppingCart - holds all the entries (an array of of CartEntry objects)
Order - initializes a ShoppingCart, and has a method that calculates the total price of the cart (by going into the instance of ShoppingCart, and then into each instance of CartEntry to find the price and quantity of each entry)

Implementation B:
CartEntry - holds the price and quantity of one entry, and has a method that uses these attributes calculates the price of the entry
ShoppingCart -  holds all the entries (an array of of CartEntry objects), and has a method that calculates the total price of all the entries (by calling the method in CartEntry on each entry object, which calculates the price of each individual entry)
Order - holds a ShoppingCart object (which itself holds an array of CartEntry objects), and has a method that calculates the final price (accounting for tax) for the whole order, by calling the method in the ShoppingCart class on the ShoppingCart object, which calculates the total price of all the entries (without tax).


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

ShoppingCart has-a (or many) CartEntry objects
Order has-a ShoppingCart object


What data does each class store? How (if at all) does this differ between the two implementations?

Implementation A:
CartEntry - holds the price and quantity of one entry
ShoppingCart - holds an array of CartEntry objects
Order - holds a ShoppingCart object, and calculates the total price of the cart

Implementation B:
CartEntry - holds the price and quantity of one entry, and calculates the price of the entry
ShoppingCart -  holds an array of of CartEntry objects, and calculates the sum price of all the entries
Order - holds a ShoppingCart object, and calculates the final price (accounting for tax) for the whole order.

A big difference between the two implementations is that in Implementation A, #total_price handles all the logic for calculating the price, which relies on the state of both the other classes. In Implementation B, the price is calculated within each class, so that the total price can be easily calculated by just calling on the method within ShoppingCart.


What methods does each class have? How (if at all) does this differ between the two implementations?

Implementation A:
CartEntry - constructor, and 2 attr_accessor methods
ShoppingCart - constructor, and 1 attr_accessor
Order - constructor, and #total_price

Implementation B:
CartEntry - constructor, and #price
ShoppingCart -  constructor, and #price
Order - constructor, and #total_price

Whoa, very different! Implementation B does not have any attr_accessor methods, so there is greater encapsulation. Instead, it has methods within each class responsible for calculating the price for that particular class.


Consider the Order#total_price method. In each implementation:
Is the logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order? Does total_price directly manipulate the instance variables of other classes?

In Implementation A, the logic in #total_price is all in Order, which is a "high level" class in this implementation. It does directly manipulate the instance variables of both CartEntry and ShoppingCart.

In Implementation B, the logic in #total_price is delegated to ShoppingCart and CartEntry. It does not directly manipulate the instance variables of the other classes.


If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

Implementation B would be easier to modify, as Implementation A relies on CartEntry to calculate the total_price.


Which implementation better adheres to the single responsibility principle?

Implementation B, as each class only relies on it's own instance methods to read and modify their instance variables.


Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

Implementation B, as the classes are connected without knowing the details of the other classes implementation.

---

For each class in your program, ask yourself the following questions:

Hotel:
What is this class's responsibility? (You should be able to describe it in a single sentence)
To manage the hotel's reservations.

Is this class responsible for exactly one thing?
No. I see that I have Hotel doing a lot of the logic that should be delegated to the other classes.

Does this class take on any responsibility that should be delegated to "lower level" classes?
Yes. Hotel reads and modifies instance variables of other classes.

Is there code in other classes that directly manipulates this class's instance variables?
Yes.

Reservation:
What is this class's responsibility?
To make a reservation.

Is this class responsible for exactly one thing?
Yes, I think so.

Does this class take on any responsibility that should be delegated to "lower level" classes?
I don't think so.

Is there code in other classes that directly manipulates this class's instance variables?
No.

DateRange:
What is this class's responsibility?
To manage all logic having to do with reservations dates/the length of stay.

Is this class responsible for exactly one thing?
I think so.

Does this class take on any responsibility that should be delegated to "lower level" classes?
No.

Is there code in other classes that directly manipulates this class's instance variables?
No.

Block:
What is this class's responsibility?
To block off a block of rooms.

Is this class responsible for exactly one thing?
Yes.

Does this class take on any responsibility that should be delegated to "lower level" classes?
No.

Is there code in other classes that directly manipulates this class's instance variables?
No.

---
Activity

Based on the answers to the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how why the resulting design would be an improvement.

In Hotel#block_reservation, I have this method looping through @all_blocks and reading the block_id for each block. I think I could have a block_id_match? method in Block instead to keep this functionality there, and then have Hotel call this method instead of reading the instance variables directly.


Then make the changes! Don't forget to take advantage of all the tests you wrote - if they're well structured, they should quickly inform you when your refactoring breaks something.

Once you're satisfied, git commit your changes and then push them to GitHub. This will automatically update your pull request.
