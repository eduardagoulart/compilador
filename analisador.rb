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

      # @todo: match com [] não acho expressão regular válida
      elsif valor.match(';') or valor.match('{') or valor.match('}')
        reservados << Token::MY_HASH[valor]

      elsif valor.match(/[+-]?[0-9][.][0-9]/)
        reservados << :FLOAT_CONT

      elsif valor.match(/[+-]?[0-9]/)
        reservados << :INTEGER_CONST

      elsif valor.match(/\w/)
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

module AnalisadorLexico
  def arquivo
    reservados = []
    letras = []

    f = File.open('soma.c', 'r')

    f.each_char do |char|
      if char.match(/\w/)
        letras << char
      elsif !char.match(/\w/)
        if letras.size > 0
          letras = letras.join
          if Token::MY_HASH[letras]
            reservados << [Token::MY_HASH[letras], letras]
          else
            reservados << [:ID, letras]
          end
          letras = []
        elsif char.match(/[+-]?[0-9][.][0-9]/)
          reservados << [:FLOAT_CONT, char]
        elsif char.match(/[+-]?[0-9]/)
          reservados << [:INTEGER_CONST, char]
        else
          if Token::MY_HASH[char]
            reservados << [Token::MY_HASH[char], char]
            elsif char.match(/\s/)
          else
            puts reservados
            puts "#{char} - não pertence"
            exit
          end
        end
      end
    end

    puts reservados
    f.close

  end
end

include AnalisadorLexico
arquivo