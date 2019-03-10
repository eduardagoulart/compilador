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

  # @todo: split no código utilizar apenas espaços
  def tokeniza
    entrada = le_arquivo

    token = []
    reservados = []
    entrada = entrada.join.split(/ /)


    entrada.each do |valor|
      if Token::MY_HASH[valor]
        # reservados << valor
        reservados << Token::MY_HASH[valor]

      elsif valor.match(';') or valor.match('{') or valor.match('}')
        reservados << Token::MY_HASH[valor]

      elsif valor.match(/[+-]?[0-9][.][0-9]/)
        reservados << :FLOAT_CONT

      elsif valor.match(/[+-]?[0-9]/)
        reservados << :INTEGER_CONST
        
      elsif valor.match(/[a-zA-Z]/)
        reservados << :ID

      elsif valor.match(/\s\n/) or valor.match(/(.|\s)*/)
        next
      else
        puts valor
        puts "Caractere inválido na linguagem"
        break
      end
    end
    puts reservados.join(" ")
  end
end

include Lexema
tokeniza