## Prompts   

1. **What classes does each implementation include? Are the lists the same?**  

Both implementations use the same three classes: CartEntry, ShoppingCart and Order.

2.**Write down a sentence to describe each class.**  

*Implementation A*:

CartEntry class:   
Has an initialize method that creates two instance variables, @unit_price and @quantity, both of which have read and write capability provided by the helper method attr_accessor.  

ShoppingCart class:  
 Has an initialize method that initializes one instance variable, @entries, that is an array and has read and write access from outside the class provided by the helper method attr_accessor.  

Order class:    
Has an initialize method that initializes one instance variable, @cart, which is an instance of the ShoppingCart class, and a total_price method that calculates the total of the Order.  

*Implementation B*:  

CartEntry class:  
Has an initialize method that initializes two instance variables, @unit_price and @quantity, and a price method that calculates and returns the price of the CartEntry my multiplying the @unit_price by the @quanty.  

ShoppingCart class:   
Has an initialize method that initializes one instance variable, @entries, which is an empty array, and a price method that calculates the total of all the CartEntrys in the instance of ShoppingCart.  

Order class:  
Has an initialize method that initializes one instance variable, @cart, which is an instance of the ShoppingCart class, and a total_price method that calculates the total of the order by adding tax to the result of the price method in ShoppingCart.  

3. **How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**

*Implementation A*:  
    The Order class accesses the instance variables of the ShoppingCart and CartEntry classes to calculate the total_price of the Order.  

*Implementation B*:  
    The ShoppingCart class calls the CartEntry#price method to calculate the price of all of the CartEntry instances in @entries.  
    The Order class then calls the ShoppingCart#price method to calculate the total (with tax) of everything in @cart.  


4. **What data does each class store? How (if at all) does this differ between the two implementations?**  

The same data is stored in each class in the two implementations. The CartEntry class stores data for the quantity and unit_price of each instance of CartEntry in the ShoppingCart. The ShoppingCart contains an array of all of these CartEntry instances. The Order class contains a constant variable set equal to the sales tax, as well as an instance of ShoppingCart.  

5. **What methods does each class have? How (if at all) does this differ between the two implementations?**  

The methods contained in the three classes are different between the two implementations.  

In implementation A the CartEntry and ShoppingCart classes only contain initialize methods, and otherwise only deal with the state of the class. In A the Order class contains one master method with all of the logic for calculating the price of the order. This price method directly accesses the instance variables of the ShoppingCart and CartEntry classes to calculate the total_price of the Order.  

In implementation B the CartEntry and ShoppingCart classes have their own price methods that contain the logic of calculating the Order total_price that directly read the instance variables of their class.  

CartEntry has a method the calculates the cost of an instance of CartEntry, and the ShoppingCart class has a method that calculates the total cost of all the CartEntry instances in @entries by calling the CartEntry price method from within the ShoppingCart class. In B the Order class total_price method simply adds tax to the result of calling the ShoppingCart price method.  

6. **Consider the Order#total_price method. In each implementation:  
 Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?  
 Does total_price directly manipulate the instance variables of other classes?**  

In A, the logic is entirely within the Order class, with the Order class's total_price method directly reading the instance variables of the CartEntry and ShoppingCart to calculate the total_price.  

In B, logic to compute the price is delegated to the lower level classes. The logic of the total_price method that needs access to the CartEntry and ShoppingCart instance variables is directly in those classes. Higher level classes access the data for calculating the total price by calling methods on the instances of the lower level classes instead of reading their instance variables directly.  

7. **If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**

Implementation B is easier to modify, because you could directly change the logic of it's price method to give a price reduction if the quantity is large enough.  

8. **Which implementation better adheres to the single responsibility principle?**    

Implementation B better adheres to the single responsibility principle. The classes in B have both state and behavior, and method of higher level classes don't directly rely on the state of lower level classes.  

9. **Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**  

## Activity  

The valid_dates method in my booking class raises an argument error if the checkout day is before or equal the checkin day. Since this method deals specifically with dates, so it would make more sense to have this validation in my DateRange class when I initialize a new instance of DateRange.  
