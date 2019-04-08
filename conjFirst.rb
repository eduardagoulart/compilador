module ConjuntoFirst
  MY_HASH= {
    'tipo' => ['INT','FLOAT'],
    'decl_comando' => ['INT','FLOAT','LBRACE','ID','IF','WHILE','READ','PRINT','FOR'],
    'declaracao' => ['INT','FLOAT'],
    'decl2' => ['COMMA','PCOMMA','ATTR'],
    'comando' => ['LBRACE','ID','IF','WHILE','READ','PRINT','FOR'],
    'bloco' => ['LBRACE'],
    'atribuicao' => ['ID'],
    'comando_se'=> ['IF'],
    'comando_senao'=> ['ELSE'],
    'comando_read'=> ['READ'],
    'comando_enquanto'=> ['WHILE'],
    'comando_print'=> ['PRINT'],
    'comando_for'=> ['FOR'],
    'atribuicao_for'=> ['ID','RBRACKET'],
    'expressao' => ['ID','INTEGER_CONST','FLOAT_CONST','LBRACKET'],
    'relacao_opc' => ['LT','LE','GT','GE','ID','INTEGER_CONST','FLOAT_CONST','LBRACKET'],
    'op_rel' => ['LT','LE','GT','GE'],
    'adicao' => ['ID','INTEGER_CONST','FLOAT_CONST','LBRACKET'],
    'adicao_opc' => ['PLUS','MINUS'],
    'termo' => ['ID','INTEGER_CONST','FLOAT_CONST','LBRACKET'],
    'termo_opc' => ['MULT','DIV'],
    'op_mult' =>['MULT','DIV'],
    'fator' => ['ID','INTEGER_CONST','FLOAT_CONST','LBRACKET'],
    'casa' => ['unexpected token']
  }

end
