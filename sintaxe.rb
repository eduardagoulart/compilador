require_relative 'analisador_lexico'

module AnalisadorSintatico
  def analise_sintatica
    @token_entrada, @matriz = Automata::state_zero
    @index = 0
    # puts @matriz[@index][1]
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
      puts "ERRO: INT esperado na linha #{@matriz[@index][2]}"
      @index += 1
    end
  end

  def decl_comando()
    if @matriz[@index][1] == "INT" or @matriz[@index][1] == "FLOAT"
      declaracao()
      decl_comando()
    elsif @matriz[@index][1] == "LBRACE" or @matriz[@index][1] == "ID" or @matriz[@index][1] == "IF" or
      @matriz[@index][1] == "WHILE" or @matriz[@index][1] == "READ" or @matriz[@index][1] == "PRINT" or @matriz[@index][1] == "FOR"
      comando()
      decl_comando()
    else
      @index += 1
    end
  end

  def declaracao()
    if @matriz[@index][1] == "INT" or @matriz[@indez][1] == "FLOAT"
      tipo()
      casa("ID")
      decl2()
    else
      puts "ERRO: valor não esperado #{@matriz[@index][1]} na linha #{@matrz[@index][2]}"
      @index += 1
    end
  end

  def decl2()
    if @matriz[@index][1] == "COMMA"
      casa("COMMA")
      casa("ID")
      decl2()
    elsif @matriz[@index][1] == "PCOMMA"
      casa("PCOMMA")
    elsif @matriz[@index][1] == "ATTR"
      casa("ATTR")
      expressao()
      decl2()
    else
      puts "ERRO: valor não esperado #{@matriz[@index][1]} na linha #{@matriz[@index][2]}"
      @index += 1
    end
  end

  def tipo()
    if @matriz[@index][1] == "INT"
      casa("INT")
    elsif @matriz[@index][1] == "FLOAT"
      casa("FLOAT")
    else
      puts "ERRO: valor não esperado #{@matriz[@index][1]} na linha #{@matriz[@index][2]}"
      @index += 1
    end
  end

  def comando()
    if @matriz[@index][1] == "LBRACE"
      bloco()
    elsif @matriz[@index][1] == "ID"
      atribuicao()
    elsif @matriz[@index][1] == "IF"
      comando_se()
    elsif @matrix[@index][1] == "WHILE"
      comando_enquanto()
    elsif @matriz[@index][1] == "READ"
      comando_read()
    elsif @matrix[@index][1] == "PRINT"
      comando_print()
    elsif @matriz[@index][1] == "FOR"
      comando_for()
    else
      retorna_erro()
    end
  end

  def bloco()
    if @matriz[@index][1] == "LBRACE"
      casa("LBRACE")
      decl_comando()
      casa("RBRACE")
    else
      retorna_erro()
    end
  end

  def atribuicao()
    if @matriz[@index][1] == "ID"
      casa("ID")
      casa("ATTR")
      expressao()
      casa("PCOMMA")
    else
      retorna_erro()
    end
  end

  def comando_se()
    if @matriz[@index][1] == "IF"
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
    if @matriz[@index][1] == "ELSE"
      casa("ELSE")
      comando()
    else
      @index += 1
    end
  end

  def comando_enquanto()
    if @matriz[@index][1] == "WHILE"
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
    if @matriz[@index][1] == "READ"
      casa("READ")
      casa("ID")
      casa("PCOMMA")
    else
      retorna_erro()
    end
  end

  def comando_print()
    if @matriz[@index][1] == "PRINT"
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
    if @matriz[@index][1] == "FOR"
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
    if @matriz[@index][1] == "RBRACKET"
      casa("RBRACKET")
      comando()
    elsif @matriz[@index][1] == "ID"
      casa("ID")
      casa("ATTR")
      expressao()
    end
  end

  def expressao()
    if @matriz[@index][1] == "ID" or @matriz[@index][1] == "INTEGER_CONST" or @matriz[@index][1] == "FLOAT_CONST" or @matriz[@index][1] == "LBRACKET"
      adicao()
      relacao_opc()
    else
      retorna_erro()
    end
  end

  def relacao_opc()
    if @matriz[@index][1] == "LT" or @matriz[@index][1] == "LE" or @matriz[@index][1] == "GT" or @matriz[@index][1] == "GE"
      op_rel()
      adicao()
      relacao_opc()
    else
      @index += 1
    end
  end

  def op_rel()
    if @matriz[@index][1] == "LT"
      casa("LT")
    elsif @matriz[@index][1] == "LE"
      casa("LE")
    elsif @matriz[@index][1] == "GT"
      casa("GT")
    elsif @matriz[@index][1] == "GE"
      casa("GE")
    else
      retorna_erro()
    end
  end

  def adicao()
    if @matriz[@index][1] == "ID" or @matriz[@index][1] == "INTEGER_CONT" or @matriz[@index][1] == "FLOAT_CONST" or @matriz[@index][1] == "LBRACKET"
      termo()
      adicao_opc()
    else
      retorna_erro()
    end
  end

  def adicao_opc()
    if @matriz[@index][1] == "PLUS" or @matriz[@index][1] == "MINUS"
      op_adicao()
      termo()
      adicao_opc()
    else
      @index += 1
    end
  end

  def op_adicao()
    if @matriz[@index][1] == "PLUS"
      casa("PLUS")
    elsif @matriz[@index][1] == "MINUS"
      casa("MINUS")
    else
      retorna_erro()
    end
  end

  def termo()
    if @matriz[@index][1] == "ID" or @matriz[@index][1] == "INTEGER_CONST" or @matriz[@index][1] == "FLOAT_CONST" or @matriz[@index][1] == "LBRACKET"
      fator()
      termo_opc()
    else
      retorna_erro()
    end
  end

  def termo_opc()
    if @matriz[@index][1] == "MULT" or @matriz[@index][1] == "DIV"
      op_mult()
      fator()
      termo_opc()
    else
      @index += 1
    end
  end

  def op_mult()
    if @matriz[@index][1] == "MULT"
      casa("MULT")
    elsif @matriz[@index][1] == "DIV"
      casa("DIV")
    else
      retorna_erro()
    end
  end

  def fator()
    if @matriz[@index][1] == "ID"
      casa("ID")
    elsif @matriz[@index][1] == "INTEGER_CONST"
      casa("INTEGER_CONST")
    elsif @matriz[@index][1] == "FLOAT_CONST"
      casa("FLOAT_CONST")
    elsif @matriz[@index][1] == "LBRACKET"
      casa("LBRACKET")
      expressa()
      casa("RBRACKET")
    end
  end

  def casa(token_esperado)
    if @matriz[@index][1].to_s == token_esperado.to_s
      puts "to passando por aqui #{@matriz[@index][1]} no indice #{@index}"
      @index += 1
      if @index < @matriz.length
        return @matriz[@index][1]
      else
        exit!
      end
    else
      retorna_erro()
    end
  end

  def retorna_erro()
    puts "ERRO: valor #{@matriz[@index][1]} não encontrado na linha #{@matriz[@index][2]}"
    @index += 1
  end

end

include AnalisadorSintatico
analise_sintatica
