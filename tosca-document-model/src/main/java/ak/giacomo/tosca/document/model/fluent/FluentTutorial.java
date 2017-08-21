package ak.giacomo.tosca.document.model.fluent;

/**
 * Created by ak435s on 8/20/2017.
 */

/*

https://dzone.com/articles/java-fluent-api-designer-crash

Grammar ::= (
  'SINGLE-WORD' |
  'PARAMETERISED-WORD' '('[A-Z]+')' |
  'WORD1' 'OPTIONAL-WORD'? |
  'WORD2' ( 'WORD-CHOICE-A' | 'WORD-CHOICE-B' ) |
  'WORD3'+
)

Java impplementation of these rules:
- Every DSL “keyword” becomes a Java method
- Every DSL “connection” becomes an interface
- When you have a “mandatory” choice (you can’t skip the next keyword), every keyword of that choice is a method in the current interface. If only one keyword is possible, then there is only one method
- When you have an “optional” keyword, the current interface extends the next one (with all its keywords / methods)
- When you have a “repetition” of keywords, the method representing the repeatable keyword returns the interface itself, instead of the next interface
- Every DSL subdefinition becomes a parameter. This will allow for recursiveness
*/

public class FluentTutorial
{
    // Initial interface, entry point of the DSL
    // Depending on your DSL's nature, this can also be a class with static
    // methods which can be static imported making your DSL even more fluent
    public interface Start {
        End singleWord();
        End parameterizedWord( String parameter);
        Intermediate1 word1();
        Intermediate2 word2();
        Intermediate3 word3();
    }

    // Terminating interface, might also contain methods like execute();
    public interface End {
        void end();
    }

    // Intermediate DSL "step" extending the interface that is returned
    // by optionalWord(), to make that method "optional"
    public interface Intermediate1 extends End {
        End optionalWord();
    }

    // Intermediate DSL "step" providing several choices (similar to Start)
    public interface Intermediate2 extends End {
        End wordChoice1();
        End wordChoice2();
    }

    // Intermediate interface returning itself on word3(), in order to allow
    // for repetitions. Repetitions can be ended any time because this
    // interface extends End
    interface Intermediate3 extends End {
        Intermediate3 word3();
    }
}
