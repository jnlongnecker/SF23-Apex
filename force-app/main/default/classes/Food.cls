public abstract class Food implements FlavorProfile /*, OtherInterface */ {
  public List<String> flavors { get; private set; }

  public String name { get; private set; }

  /* default constructor is the constructor that is made automatically when you define no constructors */

  // zero-argument constructor
  public Food() {
    this('Gloop');
  }

  // one-argument constructor
  public Food(String name) {
    this(null, name);
  }

  // two-argument constructor
  public Food(List<String> startingFlavors, String name) {
    this.name = name;
    flavors = new List<String>(startingFlavors);
  }

  public abstract Boolean isDelicious();

  /* Classes, interfaces and methods are final by default. The virtual keyword allows them to be overridden */
  public virtual void addFlavor(String flavor) {
    flavors.add(flavor);
  }

  public virtual String flavorProfile() {
    if (flavors == null || flavors.size() == 0) {
      return 'tasteless';
    }

    String flavorProfile = flavors[0];
    if (flavors.size() == 1) {
      return flavorProfile;
    }

    for (Integer i = 1; i < flavors.size() - 1; i++) {
      String flavor = flavors[i];
      flavorProfile += ', ' + flavor;
    }

    flavorProfile = ' and ' + flavors[flavors.size() - 1];

    return flavorProfile;
  }

  /*
    Method overloading is when you have two methods with the same name that accept different parameters
    The method with the parameters that match will be the one that is called
  */

  class Calculator {
    public Integer add(Integer a, Integer b) {
      System.debug('We are adding integers!');
      return a + b;
    }

    public Double add(Double a, Double b) {
      System.debug('We are adding doubles!');
      return a + b;
    }

    public Double add(Integer a, Double b) {
      System.debug('We are adding integers and doubles!');
      return a + b;
    }

    public Double add(Double a, Integer b) {
      return a + b;
    }
  }
}
