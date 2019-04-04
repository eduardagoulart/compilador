require_relative 'analisador_lexico'

module AnalisadorSintatico
  def analise_sintatica
    @token_entrada, @matriz = Automata::state_zero
    @index = 0
    programa()
  end

  def programa()
    if @matriz[@index][1].to_s == "INT"
      casa("INT")
      casa("MAIN")
      casa("LBRACKET")
      casa("RBRACKET")
      casa("LBRACE")
      decl_comando()
      casa("RBRACE")
    else
      retorna_erro
    end
  end

  def decl_comando
    if @matriz[@index][1].to_s == "INT" or @matriz[@index][1].to_s == "FLOAT"
      declaracao()
      decl_comando()
    elsif @matriz[@index][1].to_s == "LBRACE" or @matriz[@index][1].to_s == "ID" or @matriz[@index][1].to_s == "IF" or
      @matriz[@index][1].to_s == "WHILE" or @matriz[@index][1].to_s == "READ" or @matriz[@index][1].to_s == "PRINT" or 
      @matriz[@index][1].to_s == "FOR"
      comando()
      decl_comando()
    end
  end

  def declaracao()
    if @matriz[@index][1].to_s == "INT" or @matriz[@index][1].to_s == "FLOAT"
      tipo()
      casa("ID")
      decl2()
    else
      retorna_erro
    end
  end

  def decl2()
    if @matriz[@index][1].to_s == "COMMA"
      casa("COMMA")
      casa("ID")
      decl2()
    elsif @matriz[@index][1].to_s == "PCOMMA"
      casa("PCOMMA")
    elsif @matriz[@index][1].to_s == "ATTR"
      casa("ATTR")
      expressao()
      decl2()
    else
      retorna_erro
    end
  end

  def tipo()
    if @matriz[@index][1].to_s == "INT"
      casa("INT")
    elsif @matriz[@index][1].to_s == "FLOAT"
      casa("FLOAT")
    else
      retorna_erro
    end
  end

  def comando()
    if @matriz[@index][1].to_s == "LBRACE"
      bloco()
    elsif @matriz[@index][1].to_s == "ID"
      atribuicao()
    elsif @matriz[@index][1].to_s == "IF"
      comando_se()
    elsif @matriz[@index][1].to_s == "WHILE"
      comando_enquanto()
    elsif @matriz[@index][1].to_s == "READ"
      comando_read()
    elsif @matriz[@index][1].to_s == "PRINT"
      comando_print()
    elsif @matriz[@index][1].to_s == "FOR"
      comando_for()
    else
      retorna_erro()
    end
  end

  def bloco()
    if @matriz[@index][1].to_s == "LBRACE"
      casa("LBRACE")
      decl_comando()
      casa("RBRACE")
    else
      retorna_erro()
    end
  end

  def atribuicao()
    if @matriz[@index][1].to_s == "ID"
      casa("ID")
      casa("ATTR")
      expressao()
      casa("PCOMMA")
    else
      retorna_erro()
    end
  end

  def comando_se()
    if @matriz[@index][1].to_s == "IF"
      casa("IF")
      casa("LBRACKET")
      expressao()
      casa("RBRACKET")
      comando()
      comando_senao()
    else
      retorna_erro()
    end
  end

  def comando_senao()
    if @matriz[@index][1].to_s == "ELSE"
      casa("ELSE")
      comando()
    end
  end

  def comando_enquanto()
    if @matriz[@index][1].to_s == "WHILE"
      casa("WHILE")
      casa("LBRACKET")
      expressao()
      casa("RBRACKET")
      comando()
    else
      retorna_erro()
    end
  end

  def comando_read()
    if @matriz[@index][1].to_s == "READ"
      casa("READ")
      casa("ID")
      casa("PCOMMA")
    else
      retorna_erro()
    end
  end

  def comando_print()
    if @matriz[@index][1].to_s == "PRINT"
      casa("PRINT")
      casa("LBRACKET")
      expressao()
      casa("RBRACKET")
      casa("PCOMMA")
    else
      retorna_erro()
    end
  end

  def comando_for()
    if @matriz[@index][1].to_s == "FOR"
      casa("FOR")
      casa("LBRACKET")
      atribuicao_for()
      casa("PCOMMA")
      expressao()
      casa("PCOMMA")
    else
      retorna_erro()
    end
  end

  def atribuicao_for()
    if @matriz[@index][1].to_s == "RBRACKET"
      casa("RBRACKET")
      comando()
    elsif @matriz[@index][1].to_s == "ID"
      casa("ID")
      casa("ATTR")
      expressao()
    end
  end

  def expressao()
    if @matriz[@index][1].to_s == "ID" or @matriz[@index][1].to_s == "INTEGER_CONST" or @matriz[@index][1].to_s == "FLOAT_CONST" or @matriz[@index][1].to_s == "LBRACKET"
      adicao()
      relacao_opc()
    else
      retorna_erro()
    end
  end

  def relacao_opc()
    if @matriz[@index][1].to_s == "LT" or @matriz[@index][1].to_s == "LE" or @matriz[@index][1].to_s == "GT" or @matriz[@index][1].to_s == "GE"
      op_rel()
      adicao()
      relacao_opc()
    end
  end

  def op_rel()
    if @matriz[@index][1].to_s == "LT"
      casa("LT")
    elsif @matriz[@index][1].to_s == "LE"
      casa("LE")
    elsif @matriz[@index][1].to_s == "GT"
      casa("GT")
    elsif @matriz[@index][1].to_s == "GE"
      casa("GE")
    else
      retorna_erro()
    end
  end

  def adicao()
    if @matriz[@index][1].to_s == "ID" or @matriz[@index][1].to_s == "INTEGER_CONST" or @matriz[@index][1].to_s == "FLOAT_CONST" or @matriz[@index][1].to_s == "LBRACKET"
      termo()
      adicao_opc()
    else
      retorna_erro()
    end
  end

  def adicao_opc()
    if @matriz[@index][1].to_s == "PLUS" or @matriz[@index][1].to_s == "MINUS"
      op_adicao()
      termo()
      adicao_opc()
    end
  end

  def op_adicao()
    if @matriz[@index][1].to_s == "PLUS"
      casa("PLUS")
    elsif @matriz[@index][1].to_s == "MINUS"
      casa("MINUS")
    else
      retorna_erro()
    end
  end

  def termo()
    if @matriz[@index][1].to_s == "ID" or @matriz[@index][1].to_s == "INTEGER_CONST" or @matriz[@index][1].to_s == "FLOAT_CONST" or @matriz[@index][1].to_s == "LBRACKET"
      fator()
      termo_opc()
    else
      retorna_erro()
    end
  end

  def termo_opc()
    if @matriz[@index][1].to_s == "MULT" or @matriz[@index][1].to_s == "DIV"
      op_mult()
      fator()
      termo_opc()
    end
  end

  def op_mult()
    if @matriz[@index][1].to_s == "MULT"
      casa("MULT")
    elsif @matriz[@index][1].to_s == "DIV"
      casa("DIV")
    else
      retorna_erro()
    end
  end

  def fator()
    if @matriz[@index][1].to_s == "ID"
      casa("ID")
    elsif @matriz[@index][1].to_s == "INTEGER_CONST"
      casa("INTEGER_CONST")
    elsif @matriz[@index][1].to_s == "FLOAT_CONST"
      casa("FLOAT_CONST")
    elsif @matriz[@index][1].to_s == "LBRACKET"
      casa("LBRACKET")
      expressa()
      casa("RBRACKET")
    else
      retorna_erro()
    end
  end

  def casa(token_esperado)
    if @matriz[@index][1].to_s == token_esperado.to_s
      puts "to passando por aqui #{@matriz[@index][1].to_s} no indice #{@index}"
      @index += 1
      if @index < @matriz.length
        return @matriz[@index][1].to_s
      else
        exit!
      end
    else
      retorna_erro()
    end
  end

  def retorna_erro()
    puts "ERRO: valor #{@matriz[@index][1].to_s} não encontrado na linha #{@matriz[@index][2]}"
  end

end

include AnalisadorSintatico
analise_sintatica
