require_relative 'analisador_lexico'

module AnalisadorSintatico
  def analise_sintatica
    @token_entrada, matriz = Automata::state_zero
    @index = 0
    programa()
    # lexema.each_with_index do |valor, index|
    #  programa(lexema[index], index)
    #  lexema[index]
    # end
  end
  def programa()
    if @token_entrada[@index].to_s == "INT"
      casa("INT")
      casa("MAIN")
      casa("LBRACKET")
      casa("RBRACKET")
      casa("LBRACE")
      # decl_comando()
      casa("RBRACE")
    end
  end
  def casa(token_esperado)
    if @token_entrada[@index].to_s == token_esperado.to_s
      puts "to passando por aqui #{@token_entrada[@index]} no indice #{@index}"
      @index += 1
      if @index < @token_entrada.length
        return @token_entrada[@index]
      end
      exit!
    end
  end
end

include AnalisadorSintatico
analise_sintatica
