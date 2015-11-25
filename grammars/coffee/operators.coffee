# CHANGELOG
# Written by Josh Grooms on 20151121


operators =
    match:
        ///(
            \, |
            \; |
            \? |
            \~ |
            \. | \.\* |
            \: | \:\: |
            \^ | \^\= |
            \% | \%\= |
            \= | \=\= |
            \! | \!\= |
            \* | \*\= |
            \/ | \/\= |
            \& | \&\= | \&\& |
            \| | \|\= | \|\| |
            \+ | \+\= | \+\+ |
            \- | \-\= | \-\- |
            \> | \>\= | \>\> | \>\>\= |
            \< | \<\= | \<\< | \<\<\= |

            \-\> | \-\>\*
        )///

    name: 'operator.character.cpp';


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


enclosures =
    [
        {
            match: /\[/;
            name: 'enclosure.index.open.cpp';
        }
        {
            match: /\]/;
            name: 'enclosure.index.close.cpp';
        }
        {
            match: /\(/;
            name: 'enclosure.group.open.cpp';
        }
        {
            match: /\)/;
            name: 'enclosure.group.close.cpp';
        }
        {
            match: /\{/;
            name: 'enclosure.block.open.cpp';
        }
        {
            match: /\}/;
            name: 'enclosure.block.close.cpp';
        }
    ];

module.exports = [ operators, operatorWords, enclosures ];
