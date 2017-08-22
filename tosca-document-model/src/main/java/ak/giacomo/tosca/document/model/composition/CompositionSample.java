package ak.giacomo.tosca.document.model.composition;

import static ak.giacomo.tosca.document.model.composition.ToscaDocumentComposition.*;

/**
 * Created by ak435s on 8/22/2017.
 */
class CompositionSample
{
    void doIt( Document document) {
        document.end();

        document.toscaDefinitionVersion( "tosca_simple_yaml_1_0")
                .dataTypes()
                    .dataType("DTName1")
                        .derivedFrom("tosca.types.Root")
                        .version("3.0")
                        .metadata()
                            .field("metedata-key1", "metadata-value1")
                            .field("metedata-key2", "metadata-value2")
                            .field("metedata-key3", "metadata-value3").end()
                    .dataType("DTName2")
                        .derivedFrom("string")
                        .constraints()
                            .maxLength( 10)
                            .validValues("a", "b").end()
                    .dataType("DTName3")
                .nodeTypes()
                    .nodeType("NTName1")
                        .metadata()
                            .field("metedata-key1", "metadata-value1")
                            .field("metedata-key2", "metadata-value2").end()
                    .nodeType("NTName2")
                .dataTypes()
                    .dataType("DTName1")
                .end();
    }
}
