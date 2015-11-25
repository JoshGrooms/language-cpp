# CHANGELOG
# Written by Josh Grooms on 20151121

# COMMENTBLOCK - Captures any valid block comment in C and C++.
commentBlock =
    begin: /(\/\*)/;
    beginCaptures:
        1: name: 'comment.block.open.cpp';
    end: /\*\//;
    endCaptures: 'comment.block.close.cpp';
    contentName: 'comment.block.content.cpp';
    name: 'comment.block.cpp';
# COMMENTLINE - Captures any valid single-line comment in C and C++.
commentLine =
    match: /(\/\/)(.*)\r?\n/;
    captures:
        1: name: 'comment.line.open.cpp';
        2: name: 'comment.line.content.cpp';
    name: 'comment.line.cpp';
# COMMENTSECTION - Captures comments that are intended to denote broad sections of code.
commentSection =
    match: /(\/\*\*)(.*)(\*\*\/)\r?\n/;
    captures:
        1: name: 'comment.section.open.cpp';
        2: name: 'comment.section.title.cpp';
        3: name: 'comment.section.close.cpp';
    name: 'comment.section.cpp';



## DOCUMENTATION COMMENTS ##
docSyntax =
    match: /SYNTAX/;
    name: 'comment.documentation.syntax.cpp';

docOutput =
    match: /OUTPUT[S]?/;
    name: 'comment.documentation.output.cpp';

docInput =
    match: /INPUT[S]?/;
    name: 'comment.documentation.input.cpp';

docProperties =
    match: /PROPERTY|PROPERTIES/;
    name: 'comment.documentation.properties.cpp';
# DOCUMENTATION - Captures any documentation comments written according to my personal standard.
documentation =
    begin: /(\/\*)\s*([A-Z0-9_]+)\s*(?=\-)/;
    beginCaptures:
        1: name: 'comment.documentation.open.cpp';
        2: name: 'comment.documentation.title.cpp';
    contentName: 'comment.documentation.content.cpp';
    end: /\*\//;
    endCaptures: 'comment.documentation.close.cpp';
    patterns: [ docSyntax, docOutput, docInput, docProperties ];



# Ordering is important here
module.exports = [ commentSection, documentation, commentBlock, commentLine ];
