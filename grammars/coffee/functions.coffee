# CHANGELOG
# Written by Josh Grooms on 20151122

{ Patterns, RXP } = require('./Utilities');


# DEBLANK - Removes all whitespace from a string.
String::deblank = ->
    return @replace(/(\s*|\r|\n)/gm, '');


## PATTERN ELEMENTS ##
genericArgumentList =
    begin: /\</;
    beginCaptures: 'enclosure.generic.open.cpp';
    end: /(\>)(?:(\s*[\&\*]\s*)+)?/;
    endCaptures:
        1: name: 'enclosure.generic.close.cpp';
        2: name: 'operator.character.cpp';
    patterns:
        [
            Patterns.QualifiedType('variable.argument.generic.cpp'),
            Patterns.SimpleType('variable.argument.generic.cpp'),
            Patterns.ListSeparator,
        ]

functionSuffix =
    end:
        ///
            (\))
            #{RXP.FunctionSuffixQualifiers}
        ///;
    endCaptures:
        1: name: 'enclosure.group.close.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        4: name: 'keyword.qualifier.cpp';
        5: name: 'keyword.qualifier.cpp';

functionSuffixLookbehind =
    end:
        '''
            (?<=\\)) \\s*
            (?:
                \\s+
                \\b(
                    const       |
                    final       |
                    override
                )\\b
            )?
            (?:
                \\s+
                \\b(
                    const       |
                    final       |
                    override
                )\\b
            )?
            (?:
                \\s+
                \\b(
                    const       |
                    final       |
                    override
                )\\b
            )?
        '''.deblank();

    endCaptures:
        1: name: 'keyword.qualifier.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';






functionGenericReturn =
    begin:
        ///
            #{RXP.FunctionQualifiers}
            \s* \b(\w+)\b (\<)
        ///
    beginCaptures:
        1: name: 'keyword.qualifier.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        4: name: 'keyword.qualifier.cpp';
        5: name: 'type.name.cpp';
        6: name: 'enclosure.generic.open.cpp';
    end: /(\;)|(\{)/;
    endCaptures:
        1: name: 'operator.character.line-terminator.cpp';
        2: name: 'enclosure.block.open.cpp';
    name: 'function.declaration.generic.cpp';
    patterns:
        [
            Patterns.QualifiedType('variable.argument.generic.cpp'),
            Patterns.SimpleType('variable.argument.generic.cpp'),
            Patterns.ListSeparator,
            {
                begin:
                    ///
                        (\>)
                        #{RXP.PointerOperation}
                        \s* (\w+)
                        \s* (\() \s*
                    ///;
                beginCaptures:
                    1: name: 'enclosure.generic.close.cpp';
                    2: name: 'keyword.qualifier.cpp';
                    3: name: 'operator.character.cpp';
                    4: name: 'function.name.cpp';
                    5: name: 'enclosure.group.open.cpp';
                end: functionSuffix.end;
                endCaptures: functionSuffix.endCaptures;
                patterns:
                    [
                        Patterns.PrimitiveVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
                        Patterns.QualifiedVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
                        Patterns.SimpleVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
                        Patterns.ListSeparator,
                    ];
            }
        ];




functionPrimitiveReturn =
    begin:
        ///
            #{RXP.FunctionQualifiers}
            #{RXP.PrimitiveType}
            #{RXP.PointerOperation}
            \s* \b(\w+)\b \s*
            (\() \s*
        ///
    beginCaptures:
        1: name: 'keyword.qualifier.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        4: name: 'keyword.qualifier.cpp';
        5: name: 'keyword.qualifier.cpp';
        6: name: 'type.primitive.cpp';
        7: name: 'keyword.qualifier.cpp';
        8: name: 'operator.character.cpp';
        9: name: 'function.name.cpp';
        10: name: 'enclosure.group.open.cpp';
    end: functionSuffix.end;
    endCaptures: functionSuffix.endCaptures;
    name: 'function.declaration.primitive.cpp';

    patterns:
        [
            Patterns.PrimitiveVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
            Patterns.QualifiedVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
            Patterns.SimpleVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
            Patterns.ListSeparator,
        ];

functionPrimitiveReturnNoInput =
    match:
        ///
            #{RXP.FunctionQualifiers}
            #{RXP.PrimitiveType}
            #{RXP.PointerOperation}
            \s* \b(\w+)\b \s*
            (\() \s* (void)? \s* (\))
            #{RXP.FunctionSuffixQualifiers}
        ///
    captures:
        0: name: 'function.declaration.primitive.no-input.cpp';
        1: name: 'keyword.qualifier.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        4: name: 'keyword.qualifier.cpp';
        5: name: 'keyword.qualifier.cpp';
        6: name: 'type.primitive.cpp';
        7: name: 'keyword.qualifier.cpp';
        8: name: 'operator.character.cpp';
        9: name: 'function.name.cpp';
        10: name: 'enclosure.group.open.cpp';
        11: name: 'type.primitive.cpp';
        12: name: 'enclosure.group.close.cpp';
        13: name: 'keyword.qualifier.cpp';
        14: name: 'keyword.qualifier.cpp';
        15: name: 'keyword.qualifier.cpp';
        16: name: 'keyword.qualifier.cpp';






functionSimpleReturn =
    begin:
        ///
            #{RXP.FunctionQualifiers}
            #{RXP.SimpleType}
            #{RXP.PointerOperation}
            \s* \b(\w+)\b \s*
            (\() \s*
        ///
    beginCaptures:
        1: name: 'keyword.qualifier.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        4: name: 'keyword.qualifier.cpp';
        5: name: 'type.name.cpp';
        6: name: 'keyword.qualifier.cpp';
        7: name: 'operator.character.cpp';
        8: name: 'function.name.cpp';
        9: name: 'enclosure.group.open.cpp';
    end: functionSuffix.end;
    endCaptures: functionSuffix.endCaptures;
    name: 'function.declaration.simple.cpp';

    patterns:
        [
            Patterns.PrimitiveVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
            Patterns.QualifiedVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
            Patterns.SimpleVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
            Patterns.ListSeparator,
        ];

functionSimpleReturnNoInput =
    match:
        ///
            #{RXP.FunctionQualifiers}
            #{RXP.SimpleType}
            #{RXP.PointerOperation}
            \s* \b(\w+)\b \s*
            (\() \s* (void)? \s* (\))
            #{RXP.FunctionSuffixQualifiers}
        ///;
    captures:
        0: name: 'function.declaration.simple.no-input.cpp';
        1: name: 'keyword.qualifier.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        4: name: 'keyword.qualifier.cpp';
        5: name: 'type.name.cpp';
        6: name: 'keyword.qualifier.cpp';
        7: name: 'operator.character.cpp';
        8: name: 'function.name.cpp';
        9: name: 'enclosure.group.open.cpp';
        10: name: 'type.primitive.cpp';
        11: name: 'enclosure.group.close.cpp';
        12: name: 'keyword.qualifier.cpp';
        13: name: 'keyword.qualifier.cpp';
        14: name: 'keyword.qualifier.cpp';
        15: name: 'keyword.qualifier.cpp';





functionQualifiedReturn =
    begin:
        ///
            #{RXP.FunctionQualifiers}
            #{RXP.QualifiedType}
        ///
    beginCaptures:
        1: name: 'keyword.qualifier.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        4: name: 'keyword.qualifier.cpp';
        5: name: 'type.name.cpp';
        6: name: 'operator.character.resolution.cpp';
    end: '(?<=[\;\{])';
    # endCaptures:
    #     1: name: 'operator.character.line-terminator.cpp';
    #     2: name: 'enclosure.block.open.cpp';
    name: 'function.declaration.qualified.cpp';
    patterns:
        [
            {
                match: RXP.QualifiedType;
                captures:
                    1: name: 'type.name.cpp';
                    2: name: 'operator.character.resolution.cpp';
            }
            functionGenericReturn,
            functionSimpleReturn,
        ];



module.exports =
[
    functionGenericReturn,
    functionPrimitiveReturnNoInput,
    functionPrimitiveReturn,
    functionQualifiedReturn,
    functionSimpleReturnNoInput,
    functionSimpleReturn,
];
