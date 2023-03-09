// Write your anonymous apex in this file and run the Execute Anonymous Apex command to run the code from your org.

// sfdx force:apex:execute -f aexec/anon.apex > aexec/log.txt

List<Account> myAccounts = new List<Account>();

for (Integer i = 0; i < 25; i++) {
  myAccounts.add(new Account(name = 'Acc ' + i));
}

Database.insert(myAccounts, false);
