package ak.giacomo.tosca.document.model;

import com.google.auto.value.AutoValue;

import java.util.Optional;

/**
 * Created by ak435s on 8/23/2017.
 */
@AutoValue
public abstract class DataType
{
    public abstract Optional<String> derivedFrom();
    public abstract Optional<String> version();
    public abstract Optional<Metadata> metadata();
    public abstract Optional<String> description();
    public abstract Optional<Constraints> constraints();
    public abstract Optional<PropertyDefinitions> properties();


    public static Builder builder() {
        return new AutoValue_DataType.Builder();
    }

    @AutoValue.Builder
    public abstract static class Builder {
        public abstract Builder derivedFrom( String derivedFrom);
        public abstract Builder version( String version);
        public abstract Builder metadata( Metadata metadata);
        public abstract Builder description( String description);
        public abstract Builder constraints( Constraints constraints);
        public abstract Builder properties( PropertyDefinitions propertyDefinitions);

        public abstract DataType build();
    }


}
