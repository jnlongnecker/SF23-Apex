public class Dish implements FlavorProfile {
  private List<Food> plate;
  private FlavorProfile drink;

  public Dish() {
    plate = new List<Food>();
  }

  public void addFood(Food newFood) {
    plate.add(newFood);
  }

  public String flavorProfile() {
    String profile = 'This dish has a ';
    for (Food item : plate) {
      if (item instanceof Fruit) {
        try {
          System.debug(((Fruit) item).isDelicious());
        } catch (Fruit.BlasphemyException be) {
          be.print();
        } catch (System.NullPointerException nullException) {
          // Handle null pointer
        } catch (System.SObjectException noFieldException) {
          // Handle the attempt to get a field that doesn't exist
        } catch (System.QueryException badQuery) {
          // Handle a query that results in no rows or an exception
        } catch (System.DmlException badDML) {
          // Handle a DML result that fails
        } catch (System.Exception whateverElse) {
          // Handle the general case
        } finally {
          // Any code that gets executed regardless of exception or success
        }
      }
      profile += item.flavorProfile();
      profile += ' ' + item.name + ', a ';
    }

    profile = profile.substring(0, profile.length() - 2);
    profile += 'nd a ' + drink.flavorProfile() + ' drink.';

    return profile;
  }
}
