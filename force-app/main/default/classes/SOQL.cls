/*
    Author: Jared Longnecker
    Last Updated: 3/7/2023
    Description: Contains methods and comments to learn about SOQL
*/

public class SOQL {
  /*
        Salesforce Object Query Language
        - SQL-like syntax
        - We can use it natively in Apex
        - Query data in our org
          - Return 1 of 3 types:
            - List<sObject> : Most common
            - sObject
            - Integer : Least common
    */

  public void learningSOQL() {
    List<Account> myAccounts = [
      SELECT Name, Rating
      FROM Account
      ORDER BY AnnualRevenue DESC NULLS LAST
      LIMIT 10
    ];

    Set<String> accountNames = new Set<String>{
      'Edge Communications',
      'United Solar',
      'FBC',
      'United Gas and Oil'
    };

    /*
      SOQL Clauses
      - LIMIT : Limit the number of records returned
        SELECT Name, Rating FROM Account LIMIT 5 : Returns only the first 5 Accounts in the list

      - OFFSET : Changes where the records start from
        SELECT Name, Rating FROM Account OFFSET 5 : Returns only the LAST Accounts after the first 5

      - WHERE : Adds a filter on our query
        SELECT Name, Rating FROM Account WHERE Name = 'Edge Communications'
        SELECT Name, Rating FROM Account WHERE Name LIKE 'Ed_e%'
        SELECT Name, Rating FROM Account WHERE Name IN :accountNames
        NOT, OR, AND - SELECT Name, Rating FROM Account WHERE NOT Name = 'Edge Communications' OR Name = 'United Solar'

      - ORDER BY : Sort the records based on a field and a direction
        Direction is either ASC or DESC
        Specifiy placement of null values with NULLS FIRST or NULLS LAST
        SELECT Name, Rating FROM Account ORDER BY AnnualRevenue DESC NULLS LAST LIMIT 5

      - WITH SECURITY ENFORCED : Throw an exception if the context user does not have access to a record
        SELECT Name, Rating FROM Account WITH SECURITY ENFORCED

      - FIELDS() : Shorthand for specific fields on a record
        ALL, CUSTOM, STANDARD
        FIELDS(STANDARD) is the only type accessible from Apex
        SELECT FIELDS(STANDARD) FROM Account

      - FORMAT() : Format date, time, number and currency fields in accordance with locale settings
        SELECT Name, Rating, FORMAT(AnnualRevenue) FROM Account

      FOR : Specify what your intention is with the record
        VIEW : Update the Last Viewed Date field on the record
        REFERENCE: Update the Last Referenced Date field on the record
        UPDATE: Lock the record from being updated by anyone but us for the transaction
        SELECT Name, Rating FROM Account FOR UPDATE
    */
  }

  public void aggregateFunctions() {
    AggregateResult myResult = [
      SELECT AVG(AnnualRevenue), SUM(AnnualRevenue)
      FROM Account
    ];

    Double myAvg = myResult.get('expr0');
    Double mySum = myResult.get('expr1');

    AggregateResult myResult2 = [
      SELECT AVG(AnnualRevenue) average
      FROM Account
    ];
    Double myAvg2 = myResult2.get('average');

    Integer numAccounts = [SELECT COUNT() FROM Account];

    /*
      Aggregate Functions:
        - AVG() : Sum and average a numerical field
        - SUM() : Sum a numerical field
        - MIN() : Return the minimum of a numerical/date/datetime/time field
        - MAX() : Returns the maximum of a numerical/date/datetime/time field
        - COUNT() : Returns the number of records for the object
        - COUNT_DISTINCT() : Returns the number of unique values for a value

          SELECT AVG(AnnualRevenue) FROM Account


      Aggregate Clauses:
        - GROUP BY : Collects an aggregated value for each value in the group
          SELECT Rating, AVG(AnnualRevenue) FROM Account GROUP BY Rating
        - HAVING : Filters the GROUP BY clause
          SELECT Rating, AVG(AnnualRevenue) FROM Account GROUP BY Rating HAVING NOT Rating = null
    */
  }

  public void dateFunctions() {
    /*
      Date Functions
        - CALENDAR_YEAR()
        - CALENDAR_QUARTER()
        - DAY_IN_MONTH() *
        - DAY_IN_WEEK()  *
        - DAY_IN_YEAR()  *
        - DAY_ONLY()
        - FISCAL_MONTH()
        - FISCAL_QUARTER()
        - FISCAL_YEAR()
        - HOUR_IN_DAY()  *
        - WEEK_IN_MONTH()
        - WEEK_IN_YEAR() *

          SELECT DAY_IN_WEEK(CloseDate) FROM Opportunity GROUP BY DAY_IN_WEEK(CloseDate)
    */

    List<AggregateResult> myList = [
      SELECT DAY_IN_WEEK(CloseDate), AVG(Amount)
      FROM Opportunity
      GROUP BY DAY_IN_WEEK(CloseDate)
    ];

    List<Opportunity> recentOpps = [
      SELECT Amount, Name
      FROM Opportunity
      WHERE CALENDAR_YEAR(CloseDate) > 2021
    ];
  }

  public void relationshipQueries() {
    /*
      Relationship Queries
        - Parent-to-Child
          - EX: Account -> Contact
            SELECT Name, (SELECT Name FROM Contacts) FROM Account

          - EX: CustomObj__c -> MyObj__c
            SELECT Name, (SELECT Name FROM MyObjs__r) FROM CustomObj__c
        
        - Child-to-Parent
          - EX: Contact -> Account
            SELECT Name, Account.Name, Owner.FirstName FROM Contact

          - EX: MyObj__c -> CustomObj__c
            SELECT Name, CustomObj__r.Name FROM MyObj__c
    */

    List<Account> accWithContacts = [
      SELECT Name, (SELECT Name FROM Contacts)
      FROM Account
    ];

    Map<Id, List<Contact>> accountIdToContacts = new Map<Id, List<Contact>>();

    for (Account currAccount : accWithContacts) {
      accountIdToContacts.put(currAccount.Id, currAccount.Contacts);
    }
  }

  public void forLoopSOQL() {
    for (Account currAccount : [
      SELECT Name, (SELECT Name FROM Contacts)
      FROM Account
    ]) {
      List<Contact> associatedContacts = currAccount.Contacts;
    }

    /*
      SOQL For Loop
        - Records take up a whole lot of memory
        - If we don't really need to store the records, and just need to iterate over them:
          - This is where the SOQL for loop comes into play
        - SOQL For loops, unlike normal SOQL queries, retrieve ALL records
        - Makes calls to query and queryMore (SF query methods)
        - The below syntax will query for 200 records at a time every loop
    */

    for (List<Account> bananas : [
      SELECT Name, (SELECT Name FROM Contacts)
      FROM Account
    ]) {
      for (Account currAccount : bananas) {
        List<Contact> associatedContacts = currAccount.Contacts;
      }

      // DML Statement here!
    }
  }

  /*
    Indexing
      - SOQL is fast because it indexes what is commonly filtered
      - Filtering on Indexed fields = Faster SOQL query
      - We want to filter off of indexed fields

      - Indexed Fields are the following:
        - RecordTypeId
        - CreatedDate
        - LastModifiedDate
        - Name field
        - Email fields (Contact and Lead ONLY)
        - Id fields (foreign or primary)
        - Text, Email, Number or Auto-Number fields marked as External Id

      - Custom fields can have an index created for them
      - All custom fields can be indexed EXCEPT:
        - Multi-Select picklists
        - Text Area (Long)
        - Text Area (Rich)
        - Text (Encrypted)
        - Non-deterministic formula fields (formula fields that rely on external values)
  */

  /*
    SOQL Governor Limits
      - 100 queries per transaction
      - 50,000 records returned cumulatively by SOQL queries
      - SOQL query character limitation of 20,000 characters
  */
}
