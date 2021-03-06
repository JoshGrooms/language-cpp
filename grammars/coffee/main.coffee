# CHANGELOG
# Written by Josh Grooms on 20151121

{ makeGrammar, rule } = require('atom-syntax-tools');

grammar =
    fileTypes:      [ 'c', 'cpp', 'cxx', 'h', 'hpp' ];
    name:           'C++ Enhanced';
    # scopeName:      'source.c, source.cpp, source.cxx, source.h, source.hpp';
    scopeName:      'source.c, source.cpp';

    # Ordering is critical here
    patterns:
        [
            require('./preprocessor')
            require('./comments')
            require('./literals')

            # require('./operations')

            require('./classes')
            require('./functions')

            # require('./minutiae')
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
