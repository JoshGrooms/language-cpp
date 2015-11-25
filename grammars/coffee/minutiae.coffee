# CHANGELOG
# Written by Josh Grooms on 20151123

{ Patterns, RXP } = require('./Utilities');

# OPERATOROVERLOAD - Captures conversion operator methods declared within a class.
operatorOverload =
    match: /(operator)\s+(\w+)/;
    captures:
        1: name: 'keyword.type.cpp';
        2: name: 'type.name.cpp';

module.exports =
[
    operatorOverload,
    Patterns.PrimitiveVariable(),
    Patterns.SimpleVariable(),
];
