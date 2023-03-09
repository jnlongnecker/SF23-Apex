public class Calculator {
  public Integer add(Integer a, Integer b) {
    return a + b;
  }

  public Integer multiply(Integer a, Integer b) {
    Integer product = 0;

    if (b < 0) {
      a = 0 - a;
      b = 0 - b;
    }

    for (Integer i = 0; i < b; i++) {
      product = add(product, a);
    }

    return product;
  }

  public Integer divide(Integer dividend, Integer divisor) {
    if (divisor == 0) {
      return 0;
    }

    Integer sign = dividend * divisor > 0 ? 1 : -1;
    Integer quotient = 0;
    Integer remainder = Math.abs(dividend);
    divisor = Math.abs(divisor);

    while (remainder >= divisor) {
      remainder = add(remainder, -divisor);
      quotient++;
    }

    return quotient * sign;
  }

  public Integer mod(Integer dividend, Integer divisor) {
    if (divisor == 0) {
      return 0;
    }

    Integer sign = dividend * divisor > 0 ? 1 : -1;
    Integer remainder = Math.abs(dividend);
    divisor = Math.abs(divisor);

    while (remainder >= divisor) {
      remainder = add(remainder, -divisor);
    }

    return remainder * sign;
  }

  public Double calculate(String expression) {
    List<String> termStack = new List<String>();
    List<Double> valueStack = new List<Double>();

    for (Integer i = 0; i < expression.length(); i++) {
      String ch = expression.mid(i, 1);

      if (ch.containsAny('(')) {
        pushList(termStack, ch);
      }
      // 0-9
      if (ch.containsAny('0123456789')) {
        Integer numStart = i;
        Integer numEnd = i;
        // While the next character is a number or period
        while (
          numEnd < expression.length() &&
          (expression.mid(numEnd, 1).containsAny('0123456789.'))
        ) {
          numEnd++;
        }
        i = numEnd - 1;

        // Used to retrieve numbers with more than 1 digit
        pushList(
          valueStack,
          Double.valueOf(expression.substring(numStart, numEnd))
        );
      }
      // * or /
      if (ch.containsAny('*/')) {
        while (
          !termStack.isEmpty() && (peekList(termStack).containsAny('*/'))
        ) {
          String operator = popList(termStack);
          Double val2 = popList(valueStack);
          Double val1 = popList(valueStack);
          pushList(valueStack, evaluate(operator, val1, val2));
        }
        pushList(termStack, ch);
      }
      // ")" or + or -
      if (ch.containsAny(')+-')) {
        while (!termStack.isEmpty() && peekList(termStack) != '(') {
          String operator = popList(termStack);
          Double val2 = popList(valueStack);
          Double val1 = popList(valueStack);
          pushList(valueStack, evaluate(operator, val1, val2));
        }
        if (ch != ')') {
          pushList(termStack, ch);
        } else {
          popList(termStack);
        }
      }
    }

    if (termStack.isEmpty()) {
      return valueStack[0];
    }

    while (!termStack.isEmpty()) {
      String operator = popList(termStack);
      Double val2 = popList(valueStack);
      Double val1 = popList(valueStack);
      pushList(valueStack, evaluate(operator, val1, val2));
    }
    return valueStack[0];
  }

  private Double evaluate(String operator, Double val1, Double val2) {
    if (operator == '*') {
      return val1 * val2;
    }

    if (operator == '/') {
      return val1 / val2;
    }

    if (operator == '+') {
      return val1 + val2;
    }

    return val1 - val2;
  }

  private void pushList(List<String> l, String ch) {
    l.add(ch);
  }

  private String popList(List<String> l) {
    return l.remove(l.size() - 1);
  }

  private void pushList(List<Double> l, Double num) {
    l.add(num);
  }

  private Double popList(List<Double> l) {
    return l.remove(l.size() - 1);
  }

  private String peekList(List<String> l) {
    return l[l.size() - 1];
  }
}
