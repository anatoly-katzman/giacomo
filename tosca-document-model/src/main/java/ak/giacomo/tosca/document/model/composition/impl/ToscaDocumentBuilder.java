package ak.giacomo.tosca.document.model.composition.impl;

import ak.giacomo.tosca.document.model.Document;
import ak.giacomo.tosca.document.model.composition.DataTypeStep;
import ak.giacomo.tosca.document.model.composition.DataTypesStep;
import ak.giacomo.tosca.document.model.composition.DocumentStep;
import ak.giacomo.tosca.document.model.composition.ToscaDocumentComposition;

/**
 * Created by ak435s on 8/23/2017.
 */
public class ToscaDocumentBuilder implements ToscaDocumentComposition
{
    private Document.Builder builder = Document.builder();

    @Override
    public DocumentStep document() {
        return null;
    }

    @Override
    public DataTypesStep dataTypes() {
        return null;
    }

    @Override
    public DataTypeStep dataType() {
        return null;
    }

    public Document build() {
        return builder.build();
    }
}
