* What classes does each implementation include? Are the lists the same?
* Write down a sentence to describe each class.
* How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
* What data does each class store? How (if at all) does this differ between the two implementations?
* What methods does each class have? How (if at all) does this differ between the two implementations?
* Consider the Order#total_price method. In each implementation:
  * Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  * Does total_price directly manipulate the instance variables of other classes?
* If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
* Which implementation better adheres to the single responsibility principle?
* Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
