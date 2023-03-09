/*
    Access Modifiers
        - Keyword that determines where a bit of code can be accessed from
        - 4 Options:
            - Global (ANYWHERE) - Do not use global
            - Public (Only within the namespace)
            - Protected (Only within the hierarchy of classes)
            - Private (Only within the defining class)
*/

/* Top-level class can only be public or global */
public class Fruit extends Food {
  public enum Color {
    RED,
    BLUE,
    GREEN,
    PURPLE,
    YELLOW,
    ORANGE,
    PINK
  }

  /* Property get/set access modifier is as or more restrictive than the property access modifier */
  public Color skinColor { get; private set; }
  public Color fleshColor { get; private set; }

  public Double rating {
    get {
      Integer sum = 0;
      Integer cnt = 0;
      for (cnt = 0; cnt < ratings.size(); cnt++) {
        sum += ratings[cnt];
      }
      return sum / cnt;
    }
  }

  /* Methods and variables are private by default */
  private List<Integer> ratings;

  /* Methods or variables can be static. This means that they are accessible without an instance of the class. */
  public static Integer numFruits { get; private set; }

  private final Integer INCREMENT_BY = 1;

  {
    /* An initialization block runs before the contructor */
    numFruits += INCREMENT_BY;
  }

  public Fruit(String name, Color skinColor, Color fleshColor) {
    super(name);
    this.skinColor = skinColor;
    this.fleshColor = fleshColor;
    ratings = new List<Integer>();
  }

  public override Boolean isDelicious() {
    throw new BlasphemyException(
      'How dare you question the deliciousness of fruits?'
    );
  }

  public override void addFlavor(String flavor) {
    if (flavors.size() > 2) {
      return;
    }

    super.addFlavor(flavor);
  }

  public void addRating(Integer rating) {
    if (rating < 0) {
      rating = 0;
    }
    if (rating > 5) {
      rating = 5;
    }
    ratings.add(rating);
  }

  /* Inner classes can have an access modifier as or more restrive as the outer class */
  public class BlasphemyException extends System.Exception {
    /*
        Info about custom exceptions:
            - Not necessary for them to be inner classes
            - Could be a standalone class
            - Some methods that exception has that we can leverage:
                - getLineNumber() : Returns the line number that caused the exception to fire
                - getMessage() : Returns the exception message that was input
                - getStackTraceString() : Returns the stack trace of the exception
                - setMessage() : Sets the exception message
    */

    public void print() {
      System.debug(getMessage());
    }
  }
}
