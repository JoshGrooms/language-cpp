# CHANGELOG
# Written by Josh Grooms on 20151121

{ Patterns, RXP } = require('./Utilities');

anonymousDeclaration =
    match: /\b(class|struct|enum)\b\s*(?:\r?\n?)(\{)/;
    captures:
        1: name: 'keyword.type.cpp';
        2: name: 'operator.block.open.cpp';
    name: 'type.declaration.anonymous.cpp';

accessQualifiers =
    match: /private|protected|public/;
    name: 'keyword.qualifier.access.cpp';

classInheritance =
    begin: /(\w+)\s*(\:)\s*/;
    beginCaptures:
        1: name: 'type.name.cpp';
        2: name: 'operator.character.inherit.cpp';
    end: /(\,)|(?=\{)/;
    endCaptures:
        1: name: 'operator.character.separator.cpp';
    patterns: [ accessQualifiers, Patterns.GenericType(), Patterns.QualifiedType(), Patterns.SimpleType() ];
# CLASSDECLARATION - Captures any class declaration in C++.
classDeclaration =
    begin: /\b(class)\b\s+/;
    beginCaptures:
        1: name: 'keyword.type.cpp';
    end: /(\;)|(?=\{)/;
    endCaptures:
        1: name: 'operator.character.line-terminator.cpp';
        2: name: 'enclosure.block.open.cpp';
    name: 'type.declaration.class.cpp';
    patterns:
        [
            Patterns.GenericType(),
            Patterns.QualifiedType(),
            classInheritance,
            Patterns.SimpleType()
        ];

# NAMESPACEDECLARATION - Captures any C++ namespace declaration.
namespaceDeclaration =
    begin: /\b(namespace)\b\s+/;
    beginCaptures:
        1: name: 'keyword.type.cpp';
    end: /\{/;
    endCaptures: 'enclosure.block.open.cpp';
    name: 'type.declaration.namespace.cpp';
    patterns: [ Patterns.QualifiedType(), Patterns.SimpleType() ];
# STRUCTDECLARATION - Captures the declaration of a structure type in C and C++.
structDeclaration =
    begin: /\b(struct)\b\s+/;
    beginCaptures:
        1: name: 'keyword.type.cpp';
    end: /(\;)|(?=\{)/;
    endCaptures:
        1: name: 'operator.character.line-terminator.cpp';
        2: name: 'enclosure.block.open.cpp';
    name: 'type.declaration.struct.cpp';
    patterns: [ Patterns.GenericType(), Patterns.QualifiedType(), classInheritance, Patterns.SimpleType() ];
# USINGDECLARATION - Captures any lines that assign aliases through the 'using' keyword.
usingDeclaration =
    begin: /(using)\s+(?:(\w+)\s*(\=)\s*)?/;
    beginCaptures:
        1: name: 'keyword.control.cpp';
        2: name: 'variable.alias.cpp';
        3: name: 'operator.character.assignment.cpp';
    end: /\;/;
    endCaptures: 'operator.character.line-terminator.cpp';
    name: 'type.declaration.alias.cpp';
    patterns: [ Patterns.GenericType(), Patterns.QualifiedType(), Patterns.SimpleType() ];


genericVariableDeclaration =
    begin:
        ///
            #{RXP.VariableQualifiers}
            \b(\w+)\b (\<) \s*
        ///
    beginCaptures:
        1: name: 'keyword.qualifier.cpp';
        2: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        3: name: 'keyword.qualifier.cpp';
        4: name: 'type.name.cpp';
        5: name: 'enclosure.generic.open.cpp';
    end:
        ///
            (\>)
            #{RXP.PointerOperation}
            \s+ (\w+) \s*
            (\;) | (\=)
        ///
    endCaptures:
        0: name: 'enclosure.generic.close.cpp';
        1: name: 'keyword.qualifier.cpp';
        2: name: 'operator.character.cpp';
        3: name: 'variable.name.cpp';
        4: name: 'operator.character.line-terminator.cpp';
        5: name: 'operator.character.assignment.cpp';
    name: 'variable.declaration.cpp';
    patterns:
        [
            Patterns.QualifiedType('variable.argument.generic.cpp'),
            Patterns.SimpleType('variable.argument.generic.cpp'),
            Patterns.ListSeparator,
        ];



# Ordering is important here
module.exports =
    [
        anonymousDeclaration,
        classDeclaration,
        namespaceDeclaration,
        structDeclaration,
        usingDeclaration,

        # genericVariableDeclaration,
    ];
