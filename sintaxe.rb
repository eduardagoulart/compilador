require_relative 'analisador_lexico'

module AnalisadorSintatico
  def analise_sintatica
    @token_entrada, @matriz = Automata::state_zero
    @index = 0
    # puts @matriz[@index][1]
    programa()
    # lexema.each_with_index do |valor, index|
    #  programa(lexema[index], index)
    #  lexema[index]
    # end
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
      return "ERRO: INT esperado na linha #{@matriz[@index][2]}"
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
