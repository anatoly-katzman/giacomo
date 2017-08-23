package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface DataTypeStep extends DataTypesStep
{
    DataTypeStep derivedFrom(String baseType);

    DataTypeStep version(String baseType);

    MetadataStep<DataTypeStep> metadata();

    DataTypeStep description(String description);

    ConstraintsStep<DataTypeStep> constraints();
//  DataTypePropertyDefinitions properties ();
}
