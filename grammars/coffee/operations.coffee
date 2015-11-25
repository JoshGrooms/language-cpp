# CHANGELOG
# Written by Josh Grooms on 20151124

{ Patterns, RXP } = require('./Utilities');

operatorWords =
    match:
        ///\b(
            alignof |
            delete  |
            new     |
            sizeof  |
            typeid
        )\b///

    name: 'operator.word.cpp'

newOperation =
    begin: /new/;
    beginCaptures: 'operator.word.new.cpp';
    end: /(\()|(\[)|(\;)/;
    endCaptures:
        1: name: 'enclosure.group.open.cpp';
        2: name: 'enclosure.index.open.cpp';
        3: name: 'operator.character.line-terminator.cpp';
    patterns:
        [
            Patterns.GenericType(),
            Patterns.QualifiedType(),
            Patterns.SimpleType(),
        ];

returnOperation =
    begin: /\breturn\b/;
    beginCaptures: 'keyword.control.return.cpp';
    end: /(\()|(\[)|(\;)/;
    endCaptures:
        1: name: 'enclosure.group.open.cpp';
        2: name: 'enclosure.index.open.cpp';
        3: name: 'operator.character.line-terminator.cpp';

qualification =
    match: /\b(\w+)(\:\:)/;
    captures:
        1: name: 'type.name.cpp';
        2: name: 'operator.character.resolution.cpp';


module.exports =
[
    newOperation,
    operatorWords,
    qualification,
];
