# CHANGELOG
# Written by Josh Grooms on 20151122



# DEBLANK - Removes all whitespace from a string.
String::deblank = ->
    return @replace(/(\s*|\r|\n)/gm, '');




# RXP - A collection of regular expression patterns for common C++ code elements.
RXP =

    # FUNCTIONQUALIFIERS - An expression for any qualifier keywords that appear at the beginning of a function declaration.
    #
    #   The hacky copy-paste job seen below is an attempt to stop the insane pattern branching that has been occurring within
    #   this project. As it turns out, C++ has an incredible number of possible legal permutations for things like function
    #   or class method declarations, so in cases like this I've been trying to limit the use of subpatterns in the regular
    #   expression recognition engine. It's ugly, but it's simple and does its job.
    FunctionQualifiers:
        '''
            (?:
                \\b(
                    const       |
                    constexpr   |
                    extern      |
                    inline      |
                    static      |
                    virtual
                )\\b
                \\s+
            )?
            (?:
                \\b(
                    const       |
                    constexpr   |
                    extern      |
                    inline      |
                    static      |
                    virtual
                )\\b
                \\s+
            )?
            (?:
                \\b(
                    const       |
                    constexpr   |
                    extern      |
                    inline      |
                    static      |
                    virtual
                )\\b
                \\s+
            )?
            (?:
                \\b(
                    const       |
                    constexpr   |
                    extern      |
                    inline      |
                    static      |
                    virtual
                )\\b
                \\s+
            )?
        '''.deblank();
    FunctionName:
        '''
            (?: \\b(\\w+)\\b (\\:\\:) )?
            (?: \\b(\\w+)\\b (\\:\\:) )?
            (?: \\b(\\w+)\\b (\\:\\:) )?
            (?: \\b(\\w+)\\b (\\:\\:) )?
            \\b(\\w+)\\b
            \\s* (\\() \\s*
        '''.deblank();
    # FUNCTIONSUFFIXQUALIFIERS - An expression for any qualifier keywords that appear at the end of a function declaration.
    FunctionSuffixQualifiers:
        '''
            (?:
                \\s+
                (
                    const       |
                    final       |
                    override
                )
            )?
            (?:
                \\s+
                (
                    const       |
                    final       |
                    override
                )
            )?
            (?:
                \\s+
                (
                    const       |
                    final       |
                    override
                )
            )?
            (?:
                \\s+
                (
                    const       |
                    final       |
                    override
                )
            )?
        '''.deblank();
    # POINTEROPERATION - An expression for any pointer or reference operator uses in C++.
    PointerOperation:
        '''
            (?:
                (?: \\b(const)\\b )?
                (?: \\s* ([\\&\\*]+) )
            )?
        '''.deblank();
    # PRIMITIVETYPE - An expression for any primitive type statements made in C++.
    PrimitiveType:
        '''
            (?:
                \\b(
                    long        |
                    short       |
                    signed      |
                    unsigned
                )\\b
                \\s+
            )?
            \\b(
                auto        |
                bool        |
                char        |
                double      |
                float       |
                int         |
                long        |
                nullptr     |
                short       |
                string      |
                uchar       |
                uint        |
                ulong       |
                void
            )\\b
        '''.deblank();
    # QUALIFIEDTYPE - An expression for any type in C++ that uses the scope resolution ('::') operator.
    QualifiedType:
        '''
            (\\w+)
            (\\:\\:)
        '''.deblank();
    # VARIABLEQUALIFIERS - An expression for any qualifier keywords that can be attached to variables in C++.
    VariableQualifiers:
        '''
            (?:
                \\b(
                    const       |
                    extern      |
                    mutable     |
                    static      |
                    volatile
                )\\b
                \\s+
            )?
            (?:
                \\b(
                    const       |
                    extern      |
                    mutable     |
                    static      |
                    volatile
                )\\b
                \\s+
            )?
            (?:
                \\b(
                    const       |
                    extern      |
                    mutable     |
                    static      |
                    volatile
                )\\b
                \\s+
            )?
            (?:
                \\b(
                    const       |
                    extern      |
                    mutable     |
                    static      |
                    volatile
                )\\b
                \\s+
            )?
        '''.deblank();
    # SIMPLETYPE - An expression for any simple, non-primitive, unqualified type in C++.
    SimpleType:
        '''
            (\\w+)
        '''.deblank();

# PATTERNS - A collection of syntax pattern objects that capture common C++ code elements.
Patterns =
    # FUNCTIONQUALIFIERS - A pattern for any qualifier keywords that appear at the beginning of a fucntion delcaration.
    FunctionQualifiers:
        match: RXP.FunctionQualifiers;
        captures:
            1: name: 'keyword.qualifier.cpp';
            2: name: 'keyword.qualifier.cpp';
            3: name: 'keyword.qualifier.cpp';
            4: name: 'keyword.qualifier.cpp';

    GenericType: ->
        type = genericTypeTemplate;
        type.patterns.concat(genericTypeTemplate);
        return type;
    # LISTSEPARATOR - A pattern that captures the list separation operator (i.e. ',') in C and C++.
    ListSeparator:
        match: /\,/;
        name: 'operator.character.separator.cpp';
    # PRIMITIVETYPE - A pattern that captures any primitive type declaration in C and C++.
    PrimitiveType: (typeName = 'type.primitive.cpp') ->
        match: /// #{RXP.VariableQualifiers} #{RXP.PrimitiveType} #{RXP.PointerOperation} ///
        captures:
            1: name: 'keyword.qualifier.cpp';
            2: name: 'keyword.qualifier.cpp';
            3: name: 'keyword.qualifier.cpp';
            4: name: 'keyword.qualifier.cpp';
            5: name: 'keyword.qualifier.cpp';
            6: name: typeName;
            7: name: 'keyword.qualifier.cpp';
            8: name: 'operator.character.cpp';
            9: name: 'keyword.qualifier.cpp';
            10: name: 'operator.character.cpp';
    # PRIMITIVEVARIABLE - A pattern that captures a variable declaration of any primitive C or C++ type.
    PrimitiveVariable: (varName = 'variable.name.cpp', groupName = 'variable.declaration.primitive.cpp') ->
        match:
            ///
                #{RXP.VariableQualifiers}
                #{RXP.PrimitiveType}
                #{RXP.PointerOperation}
                \s* \b(\w+)\b (?!\:)
            ///
        captures:
            1: name: 'keyword.qualifier.cpp';
            2: name: 'keyword.qualifier.cpp';
            3: name: 'keyword.qualifier.cpp';
            4: name: 'keyword.qualifier.cpp';
            5: name: 'keyword.qualifier.cpp';
            6: name: 'type.primitive.cpp';
            7: name: 'keyword.qualifier.cpp';
            8: name: 'operator.character.cpp';;
            9: name: varName;
        name: groupName;
    # QUALIFIEDTYPE - A pattern that captures any type qualified by the use of the scope resolution operator (i.e. '::').
    #
    #   SYNTAX:
    #       P = Patterns.QualifiedType()
    #       P = Patterns.QualifiedType(typeName)
    #
    #   OUTPUT:
    #       P:          PATTERN
    #                   A pattern object that can be used directly with the Atom syntax recognition engine.
    #   OPTIONAL INPUT:
    #       typeName:   STRING
    #                   A name string that classifies any identified qualified type.
    QualifiedType: (typeName = 'type.name.cpp') ->
        match: /// #{RXP.VariableQualifiers} #{RXP.QualifiedType} ///;
        captures:
            1: name: 'keyword.qualifier.cpp';
            2: name: 'keyword.qualifier.cpp';
            3: name: 'keyword.qualifier.cpp';
            4: name: 'keyword.qualifier.cpp';
            5: name: typeName;
            6: name: 'operator.character.resolution.cpp;'
    # QUALIFIEDVARIABLE - A pattern that captures any variable declaration containing a qualified type.
    QualifiedVariable: (varName = 'variable.name.cpp', groupName = 'variable.declaration.qualified.cpp') ->
        begin:
            ///
                #{RXP.VariableQualifiers}
                #{RXP.QualifiedType}
            ///;
        beginCaptures:
            1: name: 'keyword.qualifier.cpp';
            2: name: 'keyword.qualifier.cpp';
            3: name: 'keyword.qualifier.cpp';
            4: name: 'keyword.qualifier.cpp';
            5: name: 'type.name.cpp';
            6: name: 'operator.character.resolution.cpp'
        end:
            '''
                (?<= [\\&\\*\\s] )
                \\b(\\w+)\\b
            '''.deblank();
        endCaptures:
            1: name: varName;
        name: groupName;
        patterns:
            [
                Patterns.GenericType(),
                Patterns.QualifiedType(),
                Patterns.SimpleType()
            ];
    # SIMPLETYPE - A pattern that captures any simple, non-primitive, unqualified type in C++.
    SimpleType: (typeName = 'type.name.cpp') ->
        match: /// #{RXP.VariableQualifiers} #{RXP.SimpleType} #{RXP.PointerOperation} ///;
        captures:
            1: name: 'keyword.qualifier.cpp';
            2: name: 'keyword.qualifier.cpp';
            3: name: 'keyword.qualifier.cpp';
            4: name: 'keyword.qualifier.cpp';
            5: name: typeName;
            6: name: 'keyword.qualifier.cpp';
            7: name: 'operator.character.cpp';
    # SIMPLEVARIABLE - A pattern that captures any variable declaration containing a simple type.
    SimpleVariable: (varType = 'variable.name.cpp', groupType = 'variable.declaration.simple.cpp') ->
        match:
            ///
                #{RXP.VariableQualifiers}
                #{RXP.SimpleType}
                #{RXP.PointerOperation}
                \s* \b(\w+)\b
            ///;
        captures:
            0: name: groupType;
            1: name: 'keyword.qualifier.cpp';
            2: name: 'keyword.qualifier.cpp';
            3: name: 'keyword.qualifier.cpp';
            4: name: 'keyword.qualifier.cpp';
            5: name: 'type.name.cpp';
            6: name: 'keyword.qualifier.cpp';
            7: name: 'operator.character.cpp';
            8: name: varType;
    # VARIABLEQUALIFIERS - A pattern that captures any qualifier keywords that might be attached to a variable declaration.
    VariableQualifiers:
        match: RXP.VariableQualifiers;
        captures:
            1: name: 'keyword.qualifier.cpp';
            2: name: 'keyword.qualifier.cpp';
            3: name: 'keyword.qualifier.cpp';
            4: name: 'keyword.qualifier.cpp';





genericTypeTemplate =
    begin:
        ///
            #{RXP.VariableQualifiers}
            \s* \b(\w+)\b \s* (\<)
        ///
    beginCaptures:
        1: name: 'keyword.qualifier.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        4: name: 'keyword.qualifier.cpp';
        5: name: 'type.name.cpp';
        6: name: 'enclosure.generic.open.cpp';
    end:
        ///
            (\>)
            #{RXP.PointerOperation}
        ///
    endCaptures:
        1: name: 'enclosure.generic.close.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'operator.character.cpp';
    patterns:
        [
            Patterns.QualifiedType('variable.argument.generic.cpp'),
            Patterns.SimpleType('variable.argument.generic.cpp'),
            Patterns.ListSeparator,
        ]






module.exports = { Patterns, RXP };
