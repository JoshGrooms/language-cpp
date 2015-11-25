# CHANGELOG
# Written by Josh Grooms on 20151121




keywordDeclarations =
    match:
        ///\b(
            class       |
            enum        |
            namespace   |
            operator    |
            struct      |
            template    |
            typedef     |
            typename    |
            union
        )\b///

    name: 'keyword.type.cpp';

keywordControls =
    match:
        ///\b(
            break       |
            case        |
            catch       |
            continue    |
            default     |
            else        |
            for         |
            if          |
            return      |
            switch      |
            try         |
            using       |
            while
        )\b///

    name: 'keyword.control.cpp';

keywordPrimitives =
    match:
        ///\b(
            auto        |
            bool        |
            char        |
            double      |
            float       |
            int         |
            long        |
            nullptr     |
            short       |
            string      |
            uchar       |
            uint        |
            ulong       |
            void
        )\b///

    name: 'type.primitive.cpp';

keywordQualifiers =
    match:
        ///\b(
            const       |
            constexpr   |
            extern      |
            explicit    |
            final       |
            friend      |
            inline      |
            mutable     |
            override    |
            private     |
            protected   |
            public      |
            signed      |
            static      |
            unsigned    |
            virtual     |
            volatile
        )\b///;

    name: 'keyword.qualifier.cpp';


module.exports = [ keywordDeclarations, keywordControls, keywordPrimitives, keywordQualifiers ];
