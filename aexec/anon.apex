// Write your anonymous apex in this file and run the Execute Anonymous Apex command to run the code from your org.

// sfdx force:apex:execute -f aexec/anon.apex > aexec/log.txt

Calculator calc = new Calculator();

Integer p1 = calc.Multiply(8, 7);
Integer p2 = calc.Multiply(-4, -5);
Integer p3 = calc.Multiply(-4, 5);
Integer p4 = calc.Multiply(4, -5);

System.debug(p1); // 56
System.debug(p2); // 20
System.debug(p3); // -20
System.debug(p4); // -20