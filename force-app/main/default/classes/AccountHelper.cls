public class AccountHelper {
  // Trigger Best Practice #3: Bulkify your triggers
  //    (Have your trigger be capable of handling any number of records)
  public static void validateAccounts(List<Account> toValidate) {
    for (Account currAccount : toValidate) {
      if (!matchesFormat(currAccount)) {
        continue;
      }

      if (!isValid(currAccount)) {
        currAccount.addError(
          'Account is not valid, must be divisble by 2 and 7'
        );
        continue;
      }

      currAccount.Rating = 'Hot';
    }

    // Trigger Best Practice #4: Avoid Trigger recursion
  }

  private static Boolean matchesFormat(Account acc) {
    String name = acc.Name;
    Boolean goodFormat = name.indexOf('Acc ') == 0;
    return goodFormat;
  }

  private static Boolean isValid(Account acc) {
    String name = acc.Name;
    String numberPart = name.substring(4);
    Integer value = Integer.valueOf(numberPart);

    Boolean isEven = Math.mod(value, 2) == 0;
    Boolean isDivisibleBy7 = Math.mod(value, 7) == 0;

    return isEven && isDivisibleBy7;
  }

  /*
    Accounts that fit our format:
        - Acc #
        - Acc 10
        - Acc 2
        - Acc 14 ****
        - Acc 12
        - Acc 28 ****
        - Edge Communications ****
  */

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
}

/*
    When to use what kind of trigger?

    Before
        - You need to perform complex validation (cannot use a validation rule)
        - You need to modify/adjust a value before it gets saved and is too complex for flow
        - You need to do complex calculation of a field too complicated for a formula

    After
        - You need to access system fields (CreatedDate, Id, etc)
        - You need to access the Id of your records
        - You need to see the value of your fields before your records are committed
        - You need to check what a field was changed to

    Best Practices for Triggers
        1. 1 Trigger per object
        2. Keep triggers logicless
        3. Bulkify your triggers
        4. Avoid trigger recursion
*/

