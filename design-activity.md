What classes does each implementation include? Are the lists the same?
  - Each implementation has the same class names:
    1. CartEntry
    2. ShoppingCart
    3. Order
  - The lists, what I interpret as list of classes, is the same.

Write down a sentence to describe each class.
  1. CartEntry - Responsible for creating entries for the cart
  2. ShoppingCart - responsible for making carts that can hold entries and their prices
  3. Order - calculates the shopping carts' entries total price

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  - Order relies on ShoppingCart and ShoppingCart relies on CartEntry

What data does each class store? How (if at all) does this differ between the two implementations?
  - From what I can tell, each implementation's classes store the same thing. ShoppingCart = entries and order = shopping cart instances.

What methods does each class have? How (if at all) does this differ between the two implementations?


Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  - Imp A delegated to both ShoppingCart and CartEntry by utilizing their instance variables
  - Imp B did not, it was wrapped up nicely so that only messages were sent not responsibilities.

Does total_price directly manipulate the instance variables of other classes?
  - Imp A yes. it manipulates CartEntry#unit_price and CartEntry#quantity
  - Imp B does not.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  - Imp B is easier to change than Imp A. We would add the logic to CartEntry#price

Which implementation better adheres to the single responsibility principle?
  - Imp B

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
  - Imp B

____________________________________

My Hotel

Hotel::Admin#add_reservation_to_block method was tightly coupled to Block class per Dan's comment. So I refactored the code so only messages were sent between the two classes and those loosely coupled them. For example, I added the instance reservation directly to Block#reservation_array and this was a poor idea.
