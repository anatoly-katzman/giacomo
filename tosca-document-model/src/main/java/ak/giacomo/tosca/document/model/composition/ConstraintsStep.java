package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface ConstraintsStep<T> extends EndStep<T>
{
    ConstraintsStep<T> equal(String val);

    ConstraintsStep<T> greaterThan(String val);

    ConstraintsStep<T> greaterOrEqualThan(String val);

    ConstraintsStep<T> lessThan(String val);

    ConstraintsStep<T> lessOrEqualThan(String val);

    ConstraintsStep<T> inRange(String lowerVal, String higherVal);

    ConstraintsStep<T> validValues(String... values);

    ConstraintsStep<T> length(int len);

    ConstraintsStep<T> minLength(int len);

    ConstraintsStep<T> maxLength(int len);

    ConstraintsStep<T> pattern(String pattern);
}
