require_relative 'analisador_lexico'

module AnalisadorSintatico
  def analise_sintatica
    lexema, matriz = Automata::state_zero
    lexema.each.with_index do |valor, index|
      # puts valor, index
      puts valor
      programa(valor)
    end
  end
  def programa(token_entrada)
    if token_entrada.to_s == "INT"
      puts "EAE"
      casa(token_entrada, "INT")
      puts "opa"
      casa("MAIN")
      casa("RBRACKET")
      casa("LBRACKET")
      casa("LBRACE")
      decl_comando()
      casa("RBRACE")
    end
  end
  def casa(token_entrada, token_esperado)
    if token_entrada.to_s == token_esperado.to_s
      puts "to passando por aqui"
      puts token_entrada
      return nex = 1
    end
  end
end

include AnalisadorSintatico
analise_sintatica
