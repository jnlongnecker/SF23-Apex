/*
    Created By: Jared Longnecker
    Last Updated: 03/10/2022
    Description: Best practices for coding and other specifically for Apex.
*/

public class BestPractices {
  // Returns the smallest integer in the list. Throws an error on null or empty list.

  @testVisible
  private Integer getSmallestInList(List<Integer> integerList) {
    // Check valid input
    if (integerList == null) {
      throw new IllegalArgumentException('List cannot be null.');
    }
    if (integerList.size() == 0) {
      throw new IllegalArgumentException('List cannot be empty.');
    }

    // Find minimum value
    Integer minValue = integerList[0];
    for (Integer index = 1; index < integerList.size(); index++) {
      Boolean smallerIntFound = minValue > integerList[index];
      if (smallerIntFound) {
        minValue = integerList[index];
      }
    }

    return minValue;
  }

  // The point of this method is to simply add a contact to the list
  public static void addLinkedContacts(List<Account> newAccounts) {
    List<Contact> newContacts = new List<Contact>();

    for (Account currAccount : newAccounts) {
      newContacts.add(createLinkedContact(currAccount));
    }

    insert newContacts;
  }

  private static Contact createLinkedContact(Account acc) {
    Contact newContact = new Contact(
      FirstName = 'Contact for ',
      LastName = acc.Name,
      AccountId = acc.Id,
      Phone = '123 543-1234',
      Email = 'myemail@org.com'
    );

    return newContact;
  }

  /*
    If you find that you're repeating code (around 3 times), consider pulling that repeated code
    into its own method for maintainability and to type less
  */
}

/*
    Let's list out some general coding best practices:
        - Keep your code simple and readable (KISS)
        - Modularize your code by extracting repeatable functionality
        - Comment your code (but not too much)
        - Have self-documenting code
        - Robustly test your code
        - Use dynamically retrieved values wherever possible

    Apex specific best practices:
        - Follow governor limits
            - No SOQL/SOSL/DML in loops (generally)
            - Use SOQL for loops when applicable
            - Use the Limits class to monitor your governor limit usage
            - Use asynchronous apex to refresh your governor limits if you need extra
                - 6x CPU time, 2x Heap storage, 2x SOQL query statement limit
        - Follow trigger best practices
            - 1 trigger per object
            - Keep triggers logicless
            - Avoid trigger recursion
            - Bulkify your triggers
*/

