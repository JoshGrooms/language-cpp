# CHANGELOG
# Written by Josh Grooms on 20151121


generalDirective =
    match: /^\s*\#\s*\w+/
    name: 'preprocessor.directive.cpp';


include =
    match:
        ///
            ^\s* \# \s*
            (?:include) \s+
            (?:
                ([\"\'][^\'\"]+[\"\']) |
                (\<[^\>]+\>)
            )
        ///
    captures:
        0: name: 'preprocessor.include.cpp';
        1: name: 'preprocessor.include.file.local.cpp';
        2: name: 'preprocessor.include.file.global.cpp';


define =
    match:
        ///
            ^\s* \# \s*
            (?:define) \s+
            (\w+)
        ///
    captures:
        0: name: 'preprocessor.define.cpp';
        1: name: 'preprocessor.define.name.cpp';

module.exports = [ define, include, generalDirective ];
