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
        List<Account> myAccounts = [SELECT Name, Rating FROM Account ORDER BY AnnualRevenue DESC NULLS LAST LIMIT 10];

        String myEmail = 'jared.longnecker@revature.com';

        for (Account acc : myAccounts) {
            acc.Email = myEmail;
        }

        Set<String> accountNames = new Set<String>
            {'Edge Communications', 'United Solar', 'FBC', 'United Gas and Oil'};

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
}