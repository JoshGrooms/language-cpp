# CHANGELOG
# Written by Josh Grooms on 20151123



operatorOverload =
    match: /(operator)\s+(\w+)/;
    captures:
        1: name: 'keyword.type.cpp';
        2: name: 'type.name.cpp';




module.exports =
[
    operatorOverload,
];
