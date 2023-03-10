/*
    Testing in Apex
        - Actually required in SF
        - In order for your code to be allowed in a production org or in AppExchange:
            - Must have 75% code coverage for any Apex class
            - Must have overall 75% code coverage average
            - Must have 1% code covereage for Triggers
            - These metrics do not include test classes

        - Testing Best Practices
            - Test positive cases : 
                Test to see whether, when given appropriate input, the method returns an appropriate output
            - Test negative cases :
                Test to see whether, when given inappropriate input, the method handles it properly
            - Test single cases :
                Test to see whether a method that can have many or only 1 input handles the 
                case where there is only 1 input properly
            - Test bulk cases :
                Test to see whether a method that can have many or only 1 input handles the
                case where there are many inputs (200+)
            - Test restricted user cases :
                Test to see whether a method that should respond to users with restricted access
                handles these cases properly
*/

/* Test classes can be private, public or global. They all begin with @isTest */
@isTest
public class BestPracticesTest {
  /*
    In a test environment, we don't have any data! Our access to database items is nothing
    There are a few ways that we can get data to work with:
        - @isTest(seeAllData=true)
            - This will allow us to use production data in our tests
            - This is bad practice becuase our tests now rely on the data that can change
        - Create records within the test method itself
            - This isolates the records to only the method
            - But can result in repeated code
            - Best for testing triggers
        - Create records in a method marked @testSetup
            - Only 1 @testSetup method allowed per test class
            - Not allowed if the class or any method have @isTest(seeAllData=true)
            - Run ONCE for all methods in the class and rollback all changes to data made here after each method
            - This makes it the most efficient way of using test data
  */

  @testSetup
  public static void setupTests() {
    List<Account> testAccs = new List<Account>();
    for (Integer i = 1; i < 201; i++) {
      testAccs.add(new Account(Name = 'Acc ' + i));
    }

    // insert testAccs;
  }

  /* Test methods can be private, public or global and must be static. They all begin with @isTest */
  @isTest
  public static void TP_getSmallestInList() {
    List<Integer> list1 = new List<Integer>{ 1, 5, 10, -10, 60 };
    List<Integer> list2 = new List<Integer>{ 50, 100, 25, 6000 };
    List<Integer> list3 = new List<Integer>{ -10, -5, -1000, -20 };
    List<Integer> list4 = new List<Integer>{ 1, 2, 3, 4, 5 };

    BestPractices classToTest = new BestPractices();

    Integer result1 = classToTest.getSmallestInList(list1);
    Integer result2 = classToTest.getSmallestInList(list2);
    Integer result3 = classToTest.getSmallestInList(list3);
    Integer result4 = classToTest.getSmallestInList(list4);

    System.assertEquals(-10, result1);
    System.assertEquals(25, result2);
    System.assertEquals(-1000, result3);
    System.assertEquals(1, result4);
  }

  @isTest
  public static void TN_getSmallestInList() {
    List<Integer> emptyList = new List<Integer>();
    List<Integer> nullList = null;

    BestPractices testClass = new BestPractices();
    try {
      testClass.getSmallestInList(emptyList);
    } catch (System.IllegalArgumentException e) {
      System.assertEquals('List cannot be null.', e.getMessage());
    } catch (System.Exception e) {
      System.assert(false);
    }

    try {
      testClass.getSmallestInList(nullList);
    } catch (System.IllegalArgumentException e) {
      System.assertEquals('List cannot be empty.', e.getMessage());
    } catch (System.Exception e) {
      System.assert(false);
    }
  }

  @isTest
  public static void TB_testAccountTrigger() {
    List<Account> accsToTest = AccountFactory.createAccounts(201);

    Test.startTest();
    try {
      Database.insert(accsToTest, false);
    } catch (System.Exception e) {
      System.debug('An exception occured');
      System.debug(e.getMessage());
      System.assert(false);
    }
    Test.stopTest();

    Integer numberExpected = 14;

    List<Account> accountsCreated = [SELECT Name, Rating FROM Account];
    List<Contact> contactsCreated = [SELECT FirstName, LastName FROM Contact];

    System.assertEquals(numberExpected, accountsCreated.size());
    System.assertEquals(numberExpected, contactsCreated.size());
  }

  @isTest
  public static void TRU_testAccountTrigger() {
    User devonDemo = [
      SELECT Name
      FROM User
      WHERE Profile.Name = 'Standard User'
      LIMIT 1
    ];
    List<Account> accsToTest = AccountFactory.createAccounts(201);

    Test.startTest();
    System.runAs(devonDemo) {
      Database.insert(accsToTest, false);
    }
    Test.stopTest();

    List<Account> accountsCreated = [SELECT Name, Rating FROM Account];
    List<Contact> contactsCreated = [SELECT FirstName, LastName FROM Contact];

    Integer numberExpected = 0;

    System.assertEquals(numberExpected, accountsCreated.size());
    System.assertEquals(numberExpected, contactsCreated.size());
  }
}
