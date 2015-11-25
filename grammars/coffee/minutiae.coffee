# CHANGELOG
# Written by Josh Grooms on 20151123

{ Patterns, RXP } = require('./Utilities');



# CONVERSIONOPERATOR - Captures any type conversion operator methods declared within a class.
conversionOperator =
    match: /(operator)\s+(\w+)/;
    captures:
        1: name: 'keyword.type.cpp';
        2: name: 'type.name.cpp';

primitiveOperator =
    match: /// (operator) \s+ #{RXP.PrimitiveType} ///
    captures:
        1: name: 'keyword.qualifier.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        4: name: 'keyword.qualifier.cpp';
        5: name: 'keyword.qualifier.cpp';
        6: name: 'keyword.qualifier.cpp';
        7: name: 'type.primitive.cpp';
        8: name: 'keyword.qualifier.cpp';
        9: name: 'operator.character.cpp';
        10: name: 'keyword.qualifier.cpp';
        11: name: 'operator.character.cpp';

module.exports =
[
    primitiveOperator,
    conversionOperator,
    Patterns.PrimitiveVariable(),
    Patterns.SimpleVariable(),
];
