# CHANGELOG
# Written by Josh Grooms on 20151122

{ Patterns, RXP } = require('./Utilities');



# DEBLANK - Removes all whitespace from a string.
String::deblank = ->
    return @replace(/(\s*|\r|\n)/gm, '');


## PATTERN ELEMENTS ##

# FUNCTIONSUFFIX - A pattern that captures the tail end of any function declaration.
#
#   This pattern should only be used inside of other function declaration capturing patterns (see below). It is not
#   sufficient on its own to capture function definitions as it only consistently recognizes the close parenthesis character.
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



# FUNCTIONGENERICRETURN - Captures any function declaration that returns a generic type.
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
                        \s* (?: \b(\w+)\b(\:\:) )? \b(\w+)\b \s*
                        (\() \s*
                    ///;
                beginCaptures:
                    1: name: 'enclosure.generic.close.cpp';
                    2: name: 'keyword.qualifier.cpp';
                    3: name: 'operator.character.cpp';


                    4: name: 'type.name.cpp';
                    5: name: 'operator.character.resolution.cpp';

                    6: name: 'function.name.cpp';
                    7: name: 'enclosure.group.open.cpp';
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
            {
                match:
                    ///
                        (\>)
                        #{RXP.PointerOperation}
                        \s* (\w+) \s*
                    ///
                beginCaptures:
                    1: name: 'enclosure.generic.close.cpp';
                    2: name: 'keyword.qualifier.cpp';
                    3: name: 'operator.character.cpp';
                    4: name: 'variable.name.cpp';
            }
        ];
# FUNCTIONPRIMITIVERETURN - Captures any function declaration that returns a primitive type.
functionPrimitiveReturn =
    begin:
        ///
            #{RXP.FunctionQualifiers}
            #{RXP.PrimitiveType}
            #{RXP.PointerOperation}
            \s* (?: \b(\w+)\b(\:\:) )? \b(\w+)\b \s*
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

        9: name: 'type.name.cpp';
        10: name: 'operator.character.resolution.cpp';

        11: name: 'function.name.cpp';
        12: name: 'enclosure.group.open.cpp';
    end: functionSuffix.end;
    endCaptures: functionSuffix.endCaptures;
    name: 'function.declaration.primitive.cpp';

    patterns:
        [
            Patterns.PrimitiveVariable('variable.argument.input.cpp', 'function.argument.primitive.cpp'),
            Patterns.QualifiedVariable('variable.argument.input.cpp', 'function.argument.qualified.cpp'),
            Patterns.SimpleVariable('variable.argument.input.cpp', 'function.argument.simple.cpp'),
            Patterns.SimpleType(),
            Patterns.ListSeparator,
        ];
# FUNCTIONSIMPLERETURN - Captures any function declaration that returns a non-primitive, unqualified type.
functionSimpleReturn =
    begin:
        ///
            #{RXP.FunctionQualifiers}
            #{RXP.SimpleType}
            #{RXP.PointerOperation}
            \s* (?: \b(\w+)\b(\:\:) )? \b(\w+)\b \s*
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

        8: name: 'type.name.cpp';
        9: name: 'operator.character.resolution.cpp';

        10: name: 'function.name.cpp';
        11: name: 'enclosure.group.open.cpp';
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
# FUNCTIONQUALIFIEDRETURN - Captures any function declaration that returns a qualified type.
#
#   The term 'qualified' here indicates the usage of the scope resolution operator ('::') in C++.
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
    end: '(?<=[\;\{])|(\;)|(\{)';
    endCaptures:
        1: name: 'operator.character.line-terminator.cpp';
        2: name: 'enclosure.block.open.cpp';
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

            Patterns.SimpleVariable(),
        ];



module.exports =
[
    functionGenericReturn,
    functionPrimitiveReturn,
    functionQualifiedReturn,
    functionSimpleReturn,
];
