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

# CONTROLSTATEMENTS - Captures certain control statements that would otherwise be incorrectly labeled.
#
#   This is something of a workaround that's necessary (for now) because, when attempting to capture variable declarations of
#   simple or primitive types (see exports below), certain keyword operations are incorrectly captured as well. Examples
#   include 'case' and 'return' statements.
controlStatements =
    match: /(case|return)/;
    captures:
        1: name: 'keyword.control.cpp';

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
    controlStatements,
    newOperation,
    operatorWords,
    # qualification,
];
