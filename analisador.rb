require_relative 'tokens'

module Lexema
  def le_arquivo
    letras = []

    f = File.open('soma.c', 'r')
    f.each_char do |char|
      letras << char
    end
    f.close

    return letras
  end

  # TODO: aprender a ler o vetor: a cada vez que achar uma letra, vai até encontrar um espaço
  def tokeniza
    entrada = le_arquivo

    token = []
    entrada.each do |valor|
      if valor.match(/[a-zA-Z\s]/)
        puts valor
      end
    end

  end
end

include Lexema
tokeniza