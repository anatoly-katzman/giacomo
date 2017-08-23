package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface DataType extends DataTypes
{
    DataType derivedFrom(String baseType);

    DataType version(String baseType);

    Metadata<DataType> metadata();

    DataType description(String description);

    Constraints<DataType> constraints();
//  DataTypePropertyDefinitions properties ();
}
