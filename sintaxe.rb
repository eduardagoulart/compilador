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
      # decl_comando()
      # casa("RBRACE")
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
      puts "ERRO: valor não esperado #{@matriz[@index][1]} na linha #{@matriz[@index][2]}"
      @index += 1
    end
  end

  def bloco()
    if @matriz[@index][1] == "LBRACE"
      casa("LBRACE")
      decl_comando()
      casa("RBRACE")
    else
      puts "ERRO: valor não esperado #{@matriz[@index][1]} na linha #{@matriz[@index][2]}"
      @index += 1
    end
  end

  def atribuicao()
    if @matriz[@index][1] == "ID"
      casa("ID")
      casa("ATTR")
      expressao()
      casa("PCOMMA")
    else
      puts "ERRO: valor não esperado #{@matriz[@index][1]} na linha #{@matriz[@index][2]}"
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
      puts "ERRO: Token esperado #{token_esperado} na linha #{@matriz[@index][2]}"
    end
  end

end

include AnalisadorSintatico
analise_sintatica
