public class SOSL {
  /*
    SOSL
      - Salesforce Object Search Language
      - Less efficient than querying and more resource intensive
      - BUT it has the benefit of less specificity

      - Return type List<List<sObject>>
  */

  public void allAboutSOSL() {
    List<List<sObject>> searchResult = [
      FIND '*0*0*'
      IN PHONE FIELDS
      RETURNING
        Contact(FirstName, LastName, AccountId),
        Lead(FirstName, LastName)
      LIMIT 200
    ];

    List<Contact> contacts = searchResult[0];
    List<Lead> leads = searchResult[1];

    /*
      SOSL Syntax
        - FIND : Takes in a string as your search term. Use * any number wildcard, use ? for 1 wildcard
        - IN : The fields you want to search. Takes in 4 values:
          - Phone
          - Name
          - Email
          - All (Anything except formula, roll-up summaries)
        - RETURNING : All objects and fields we want to return result matches from

        Clauses usable on an Object-by-Object basis
        - WHERE : Filters records that meet the criteria
        - ORDER BY : Sorts records by a given field in a given order
        - USING : Specifies a list view to filter off of
          FIND 'Edge' IN Name FIELDS RETURNING Account(Name, AnnualRevenue USING ListView = Recent)

        Clauses usable on either the Object or the whole Search
        - LIMIT : Limits the records returned either by the whole query or by an individual object
        - OFFSET : Offsets the records returned either by the whole query or by an individual object

        WITH
          - Only the DATA CATEGORY option is available in Apex
            - Filters the result by a Knowledge data category
            - dataGroup operator dataCategory
    */
  }

  /*
      WHEN TO USE SOQL
        - You know which object and field(s) that you want to retrieve
        - You want to get a count of the number of records that meet some criteria
        - You want to sort the results as part of a query
        - You want to get data from number, checkbox or date fields
        - You want to get data from a single object or multiple related objects

      WHEN TO USE SOSL
        - You don't specifically know which object/field has the data you're looking for
        - You want to get data from multiple objects that are not necessarily related
        - You are trying to get data in fields that cannot be indexed, but you have lots of data
  */
}

/*

  SOSL Governor Limits
    - Total number of SOSL searches: 20
    - Total number of records returned: 2,000
    - Character limit for SOSL statements: 20,000
    - Character limit for search query: 10,000
*/

