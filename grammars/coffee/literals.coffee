# CHANGELOG
# Written by Josh Grooms on 20151121


booleans =
    match:/\b(false|true)\b/;
    name: 'literal.boolean.cpp';

doubles =
    match:
        ///\b(
            \d* \. \d+
            (?:
                [eE] [\+\-]? \d+
            )?
            [lL]?
        )\b///
    captures:
        1: name: 'literal.float.double.cpp';

floats =
    match:
        ///\b(
            \d* \. \d+
            (?:
                [eE] [\+\-]? \d+
            )?
            [fF]
        )\b///
    captures:
        1: name: 'literal.float.single.cpp';

hexadecimals =
    match: /\b(0[xX](?:[0-9]|[a-f]|[A-F])+[lLuU]*)\b/;
    captures:
        1: name: 'literal.integer.hexadecimal.cpp';

integers =
    match: /\b(\d+[lLuU]*)\b/;
    captures:
        1: name: 'literal.integer.decimal.cpp';

octals =
    match: /\b(0[0-9]+[lLuU]*)\b/;
    captures:
        1: name: 'literal.integer.octal.cpp';

emptyStrings =
    match: /[\"\'][\"\']/;
    name: 'literal.string.cpp';

strings =
    begin: /(L|u8|u|U)?([\"\'])[^\(]/;
    beginCaptures:
        1: name: 'literal.string.qualifier.cpp';
        2: name: 'enclosure.string.open.cpp';
    end: /[\"\']/;
    endCaptures: 'enclosure.string.close.cpp';
    name: 'literal.string.cpp';


module.exports =
    [
        booleans,
        doubles,
        floats,
        hexadecimals,
        integers,
        octals,
        emptyStrings,
        strings
    ];
