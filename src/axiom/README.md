# Axiom, A Library with Lexer, AST and Parser of Ever

this library is for make lexer, parser be free from ever compiler and use in another softwares like `evr4d`.

well, it's not perfect. because it made with D and use D datatypes, its not usable, in out of D.

Here is a little of information about every source file in here:
    1. `ast.d`: Ast defined here.
    
    2. `axiom.d`: publics import for use lexer, etc without need to call them one by one.
    
    3. `cbased.d`: interface-layout to use cbased librarys in D
    
    4. `error.d`: Error handling.
    
    5. `help.d`: Old help message. [Will Remove in future]
    
    6. `lex.d`: Lexer of Ever.
    
    7. `pars.d`: Parser of Ever.
    
    8. `safeargs.d`: Make arguments of functions in AST usable in runtime.
    
    9. `simplelex.d`: Simple lexer for inside of blocks.
    
    10. `structer.d`: types of lexer and parser defined here.
    
    11. `tokena.d`: Tokenizer of Ever.
