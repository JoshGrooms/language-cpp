# CHANGELOG
# Written by Josh Grooms on 20151123

{ Patterns, RXP } = require('./Utilities');

operatorOverload =
    match: /(operator)\s+(\w+)/;
    captures:
        1: name: 'keyword.type.cpp';
        2: name: 'type.name.cpp';



controlStatements =
    match: /(case|return)/;
    captures:
        1: name: 'keyword.control.cpp';


argumentList =
    begin: /\(/;
    beginCaptures: 'enclosure.group.open.cpp';
    end: /\)/;
    endCaptures: 'enclsoure.group.close.cpp';
    patterns:
        [
            Patterns.PrimitiveVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
            Patterns.QualifiedVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
            Patterns.SimpleVariable('variable.argument.input.cpp', 'function.argument.input.cpp'),
            Patterns.ListSeparator,
        ];


module.exports =
[
    controlStatements,
    operatorOverload,
    # argumentList,
    Patterns.PrimitiveVariable(),
    Patterns.SimpleVariable(),
];
