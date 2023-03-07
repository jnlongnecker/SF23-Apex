public class MyFirstClass {


    /*
        Primitive Data Types
        - String
        - Boolean
        - Integer (32 bit whole number)
        - Long (64 bit whole number)
        - Decimal (32 bit floating point number)
        - Double (64 bit floating point number)
        - Date
        - Datetime
        - Time
        - Blob (Binary Large OBject)
        - ID

        ==== Non-Primitive ====
        Objects and sObjects
        - MyFirstClass
        - Account
        - Contact
        - Order
        - Case
        - Custom Objects
        - sObject

        Collections
        - List (Ordered sequence of items that can repeat)
        - Set (Unordered sequence of unique items)
        - Map (Sequence of key-value pairs)

        Enums (Sequence of aliases for unique values)

        null
    */

    public List<String> myList = new List<String>();
    public Set<Integer> myIntegerSet = new Set<Integer>();
    public Map<String, Integer> myStringMap = new Map<String, Integer>();

    public enum Season { SPRING, SUMMER, FALL, WINTER }

    public void ManipulateCollections() {
        String str1 = 'Poem';

        List<String> predefined = new List<String>{'Item 1', 'Item 2'};

        myList.add(str1);
        String valueFromList = myList.remove(0); // myList[0];

        myIntegerSet.add(50);
        myIntegerSet.add(50);
        myIntegerSet.add(25);

        System.debug(myIntegerSet.size()); // Returns 2

        Set<String> setFromList = new Set<String>(myList);
        List<Integer> listFromSet = new List<Integer>(myIntegerSet);
        List<Map<String, Set<Integer>>> listOfListOfStrings; // Weird syntax if you want!

        myStringMap.put('Key 1', 100);
        System.debug(myStringMap.get('Key 1')); // Returns 100

        Set<String> mapKeySet = myStringMap.keySet(); // Returns actual keys in the map
        myStringMap.size(); // Returns number of keys
        myStringMap.remove('Key 1');
    }

    public String GetSeasonMessage(Season aSeason) {
        String returnMessage = '';
        if (aSeason == Season.SPRING) {
            returnMessage = 'Uh-oh, I have allergies!';
        }
        else if (aSeason == Season.SUMMER) {
            returnMessage = 'Hooray, I love summer!';
        }
        else if (aSeason == Season.FALL) {
            returnMessage = 'Oooh it\'s spooky season';
        }
        else {
            returnMessage = 'Hopefully it snows where you live';
        }

        return returnMessage;
    }

    // public void PrintIfSpecial(Double input) {
    //     // Special numbers: 3.14, 7, 14, 27.4
    //     // Kinda Special numbers: -1.06, 9.86, 10

    //     String messageIfSpecial = 'WOAH that\'s a special number!';
    //     String messageIfKindaSpecial = 'That\'s kinda cool but not that cool.';
    //     String messageIfBoring = 'BOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO';

    //     switch on input {
    //         when 3.14, 14, 27.4 {
    //             System.debug(messageIfSpecial);
    //         }
    //         when 7 {
    //             // 7 is social distancing
    //             System.debug(messageIfSpecial);
    //         }
    //         when -1.06, 9.86, 10 {
    //             System.debug(messageIfKindaSpecial);
    //         }
    //         when else {
    //             System.debug(messageIfBoring);
    //         }
    //     }
    // }

    // FunWithLoops(10);

    //                                 10   
    public void FunWithLoops(Integer input) {

        // Our goal is to debug a number {input} many times

        Integer numberToPrint = 7;
        Integer count = 0;
        while (count < input) {
            System.debug(numberToPrint);

            count = count + 1;
            // count += 1;
            // count++;
            // ++count;

            Integer myValue = 10;
        }

        do {
            System.debug(numberToPrint);
        }
        while(count < input);

        // How many times has our number to print been printed?
        // Total of 11

        numberToPrint = 13;

        for (Integer index = 0; index <= input; index = index + 1) {
            System.debug(numberToPrint);
        }

        // Iterating over collections
        for (Integer index = 0; index < myList.size(); index++) {
            String myValue = myList[index];
            System.debug(myValue);
        }

        // Enhanced for loop
        for (String myValue : myList) {
            System.debug(myValue);
        }
    }

    public void DebugHelloWorld() {
        String myString = 'Hello World!';

		System.debug(myString);
    }
}

/*
    For your reference, the operators and their precedence:
        == Precedence Group 1 == 
        --x (Prefix decrement)
        ++x (Prefix increment)
        {} (Grouping)
        () (Grouping)

        == Precedence Group 2 == 
        new (Object instantiation)
        (type) (type cast)
        - (Unary negation)
        ! (Logical complement)
        
        == Precedence Group 3 == 
        / (Division)
        * (Multiplication)

        == Precedence Group 4 == 
        + (Addition)
        - (Subtraction)
        
        == Precedence Group 5 == 
        instanceof (Polymorphic type comparison)
        <= (less than or equal)
        >= (greater than or equal)
        < (less than)
        > (greater than)
        
        == Precedence Group 6 == 
        == (equality)
        != (inequality)
        
        == Precedence Group 7 == 
        || (Logical OR) 
        
        == Precedence Group 8 == 
        && (Logical AND)

        == Precedence Group 9 == 
        = (assignment)
        += (addition assignment)
        -= (subtraction assignment)
        *= (multiplication assignment)
        /= (division assignment)
        &= (and assignment)
        |= (Or assignment)
*/