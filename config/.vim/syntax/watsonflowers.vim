syntax match Type /^[[:alnum:]]*/
syntax match Type      "\<_\?\u[[:alnum:]_\$]*\>"
syntax match Number /\d/
syntax match Number /\o/
syntax match Number        "\<\d\+\(\.\d\+\)\=\>"
syntax match String /\".*\"/
"syntax match Operator /infix(\*)*\"/
syntax match Function      "\zs\<\(_\?\l[[:alnum:]_\$]*\)\>*\s*\ze("

syntax match Number        "\<\d\+\(\.\d\+\)\=\>"
syntax keyword FunnyNumbers     69 420
syntax keyword Func     func
syntax keyword Import   import
syntax keyword CreateOp infix prefix postfix
