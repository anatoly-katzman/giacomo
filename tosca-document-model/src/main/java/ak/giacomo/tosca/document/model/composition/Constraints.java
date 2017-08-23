package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface Constraints<T> extends End<T>
{
    Constraints<T> equal(String val);

    Constraints<T> greaterThan(String val);

    Constraints<T> greaterOrEqualThan(String val);

    Constraints<T> lessThan(String val);

    Constraints<T> lessOrEqualThan(String val);

    Constraints<T> inRange(String lowerVal, String higherVal);

    Constraints<T> validValues(String... values);

    Constraints<T> length(int len);

    Constraints<T> minLength(int len);

    Constraints<T> maxLength(int len);

    Constraints<T> pattern(String pattern);
}
