@isTest
public class AccountFactory {
  public static List<Account> createAccounts(Integer accountsToCreate) {
    if (accountsToCreate <= 1) {
      accountsToCreate = 201;
    }

    List<Account> testAccs = new List<Account>();
    for (Integer i = 1; i < accountsToCreate; i++) {
      testAccs.add(new Account(Name = 'Acc ' + i));
    }

    return testAccs;
  }
}
