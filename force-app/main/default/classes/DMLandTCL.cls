public class DMLandTCL {
  /*
    Data Manipulation Language
      - We use this in order to persist changes to the database
      - 6 Potential statements:
        - Insert : Used to create a new record
        - Update : Used to change the value(s) of an existing record
        - Delete : Used to remove an existing record
        - Upsert : Used to update existing records and create new records (uses insert and update)
        - Merge  : Used to combine two existing records (uses update and delete)
        - Undelete : Used to restore a record from the Recycle Bin
  */
  public void usingDML() {
    Account newAccount = new Account(
      Name = 'My Account',
      Rating = 'Hot',
      AnnualRevenue = 150000000
    );
    newAccount.Phone = '111 222-3454';

    insert newAccount;

    Contact newContact = new Contact(
      LastName = 'New',
      AccountId = newAccount.Id
    );

    insert newContact;

    List<Account> toDelete = [
      SELECT Name
      FROM Account
      WHERE Name = 'My Account'
    ];
    delete toDelete;

    insert newAccount;

    Account toUpdate = [
      SELECT Name
      FROM Account
      WHERE Name = 'My Account'
      LIMIT 1
    ];
    toUpdate.Rating = 'Cold';

    update toUpdate;

    List<Contact> myList = new List<Contact>();
    myList.add(new Contact(LastName = 'Good Contact!'));
    myList.add(new Contact(FirstName = 'Bad Contact!'));

    Database.insert(myList, false); // Allows partial insertions, so the good contact gets created!
    // Database.insert(myList); // Functionally equivalent to the standalone insert statment, throws an error!
    // insert myList; // This throws an error!
  }

  /*

  SOQL and DML Best Practices
    1. Pull DML and SOQL outside of loops
    2. Use collections for DML
    3. Use Maps to create "relationships" between otherwise unrelated records
    4. Use SOQL For Loops (list version) when you MUST use DML in a loop
  */

  public void usingTCL() {
    /*
      Transaction Control Language
        - Set savepoints
        - Rollback to save points
    */

    Savepoint sp1 = Database.setSavepoint(); // Sets our snapshot of the DB

    usingDML();

    Savepoint sp2 = Database.setSavepoint();
    Savepoint sp3 = Database.setSavepoint();

    Database.rollback(sp1); // Cause sp2 and sp3 to become invalid

    /*
      TCL Considerations
        - Does not revert IDs
        - Discard any DML that occurs AFTER the savepoint once you roll back to the savepoint
        - Rolling back to a savepoint causes all savepoints between the rollback and savepoint to be invalid
        - Rolling back does NOT reset your governor limits
        - Setting a savepoint and rolling back both count as a DML operation
    */
  }

  /*
    DML Governor Limits
      - 150 DML statements total
  */
}
