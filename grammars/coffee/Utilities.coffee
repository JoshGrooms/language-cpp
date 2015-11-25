# CHANGELOG
# Written by Josh Grooms on 20151122



# DEBLANK - Removes all whitespace from a string.
String::deblank = ->
    return @replace(/(\s*|\r|\n)/gm, '');

# RXP - A collection of regular expression patterns for common C++ elements.
RXP =
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
    PointerOperation:
        '''
            (?:
                (?: \\b(const)\\b )?
                (?: \\s* ([\\&\\*]+) )
            )?
        '''.deblank();
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
    QualifiedType:
        '''
            (\\w+)
            (\\:\\:)
        '''.deblank();
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

    SimpleType:
        '''
            (\\w+)
        '''.deblank();


Patterns =

    FunctionArguments: ->
        return
        {
            begin: /\(/;
            beginCaptures:
                0: name: 'enclosure.group.open.cpp';
            end: /\)/;
            endCaptures:
                0: name: 'enclosure.group.close.cpp';
            patterns: [ GenericVariable('variable.argument.input.cpp'), PrimitiveVariable ];
        };

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
    QualifiedType: (typeName = 'type.name.cpp') ->
        match: /// #{RXP.VariableQualifiers} #{RXP.QualifiedType} ///;
        match: RXP.QualifiedType;
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
            ///
                #{RXP.PointerOperation}
                \s* \b(\w+)\b
            ///;
        endCaptures:
            1: name: 'keyword.qualifier.cpp';
            2: name: 'operator.character.cpp';
            3: name: varName;
        name: groupName;
        patterns: [ Patterns.QualifiedType(), Patterns.SimpleType() ];

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
