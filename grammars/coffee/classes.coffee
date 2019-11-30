# CHANGELOG
# Written by Josh Grooms on 20151121

{ Patterns, RXP } = require('./Utilities');

anonymousDeclaration =
    match: /\b(class|struct|enum|enum\s+class)\b\s*(?:\r?\n)?(\{)/;
    captures:
        1: name: 'keyword.type.cpp';
        2: name: 'operator.block.open.cpp';
    name: 'type.declaration.anonymous.cpp';

accessQualifiers =
    match: /private|protected|public/;
    name: 'keyword.qualifier.access.cpp';

enumerator =
    match: /// \b (\w+) \s* (?: (\=) \s* (\d+) )? (\,)? ///;
    captures:
        1: name: 'type.enumeration.cpp';
        2: name: 'operator.character.assignment.cpp';
        3: name: 'literal.integer.decimal.cpp';
        4: name: 'operator.character.separator.cpp';

enumeration =
    begin: /// \b(enum)\b (class)? (?:\b(\w+))? \s* (?:(\:)\s*(\w+))? \s* (\{) ///;
    beginCaptures:
        1: name: 'keyword.type.cpp';
        2: name: 'keyword.type.cpp';
        3: name: 'type.name.cpp';
        4: name: 'operator.character.inherit.cpp';
        5: name: 'type.name.cpp';
        6: name: 'enclosure.block.open.cpp';
    end: /\}/;
    endCaptures:    'enclosure.block.close.cpp';
    name:           'type.declaration.enumeration.cpp';
    patterns:
        [
            enumerator,
        ];


# CLASSINHERITANCE - Captures any superclasses defined in C++ class declaration statements.
classInheritance =
    begin: /\s*(\:)\s*/;
    beginCaptures:
        1: name:    'operator.character.inherit.cpp';
    end: /\{/;
    endCaptures:    'enclosure.block.open.cpp';
    patterns:
        [
            accessQualifiers,
            Patterns.GenericType(),
            Patterns.QualifiedType(),
            Patterns.SimpleType(),
            Patterns.ListSeparator,
        ];

# CLASSDECLARATION - Captures any class declaration in C++.
classDeclaration =
    begin: /\b(class)\b\s+/;
    beginCaptures:
        1: name: 'keyword.type.cpp';
    end: '(?<=[\{\;])|(\;)|(\{)';
    endCaptures:
        1: name: 'operator.character.line-terminator.cpp';
        2: name: 'enclosure.block.open.cpp';
    name: 'type.declaration.class.cpp';
    patterns:
        [
            Patterns.GenericType(),
            Patterns.QualifiedType(),
            Patterns.SimpleType(),
            classInheritance,
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
    patterns:
        [
            Patterns.GenericType(),
            Patterns.QualifiedType(),
            Patterns.SimpleType(),
            classInheritance,
        ];

templateDeclaration =
    begin: /\b(template)(\<)/;
    captures:
        1: name: 'keyword.type.cpp';
        2: name: 'enclosure.generic.open.cpp';
    end: /\>/;
    endCaptures: 'enclosure.generic.close.cpp';
    patterns:
        [
            {
                match: /(typename|class)\s+(\w+)/;
                captures:
                    1: name: 'keyword.type.cpp';
                    2: name: 'variable.argument.generic.cpp';
            },

            Patterns.ListSeparator,
        ];

# USINGDECLARATION - Captures any lines that assign aliases through the 'using' keyword.
usingDeclaration =
    begin:
        ///
            (using) \s+
            (?: (\w+) \s* (\=) \s* )?
        ///;
    beginCaptures:
        1: name: 'keyword.control.cpp';
        2: name: 'type.name.cpp';
        3: name: 'operator.character.assignment.cpp';
    end: /\;/;
    endCaptures: 'operator.character.line-terminator.cpp';
    name: 'type.declaration.alias.cpp';
    patterns:
        [
            classDeclaration,
            Patterns.GenericType(),
            Patterns.QualifiedType(),
            Patterns.SimpleType()
        ];



# Ordering is important here
module.exports =
    [
        anonymousDeclaration,
        enumeration,
        classDeclaration,
        namespaceDeclaration,
        structDeclaration,
        templateDeclaration,
        usingDeclaration,
    ];
