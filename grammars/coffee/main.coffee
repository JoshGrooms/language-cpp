# CHANGELOG
# Written by Josh Grooms on 20151121

{ makeGrammar, rule } = require('atom-syntax-tools');

grammar =
    fileTypes:      [ 'cpp', 'h', 'hpp' ];
    name:           'C++';
    scopeName:      'source.cpp';

    # Ordering is critical here
    patterns:
        [
            require('./classes')
            require('./comments')
            require('./functions')
            require('./literals')
            require('./preprocessor')

            require('./minutiae')
            require('./keywords')
            require('./operators')
        ];


flattenPatterns = ->
    result = [];
    for pattern in grammar.patterns
        if Array.isArray(pattern)
            for subpattern in pattern
                result = result.concat(subpattern);
        else
            result = result.concat(pattern);

    grammar.patterns = result;


flattenPatterns();
makeGrammar grammar, 'CSON';
