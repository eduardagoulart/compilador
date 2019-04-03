require_relative 'tokens'

module Automata
  def le_arquivo
    letras = []

    f = File.open('soma.c', 'r')
    f.each_char do |char|
      letras << char
    end
    f.close

    return letras
  end

  def state_two(tokens)
    if Token::MY_HASH[tokens]
      return Token::MY_HASH[tokens]
    else
      return :ID
    end
  end

  def state_zero
    final_result = []
    tokens = []
    numero = []
    t = []
    input = le_arquivo
    input.each do |char|
      if char.match(/[a-zA-Z]/)
        tokens << char
      else
        t << char
        if tokens.size > 0
          tokens = tokens.join
          final_result << state_two(tokens)
          tokens = []
          if char == '(' or char == '=' or char == ';' or char == '+' or char == '-'
            final_result << Token::MY_HASH[char]
          end
        elsif char == ',' or char == ';' or char == '[' or char == ']' or char == '(' or char == ')' or char == '{' or char == '}' or char == '-' or char == '+' or char == '='
          if char == ';'
            numero = numero.join
            if numero.match(/[0-9]+[.][0-9]+/)
              final_result << :FLOAT_CONST
            elsif numero.match(/[.]([0-9])+/)
              puts "Lexema não permitido"
              exit!
            elsif numero.match(/[0-9]+/)
              final_result << :INTEGER_CONST
            end
            numero = []
          end
          final_result << Token::MY_HASH[char]
        elsif char.match(/[0-9]/) or char == '.' or char.match(';')
          numero << char
        else
          if !char.match(/\s/)
            puts "Lexema #{char} não pertencente a linguagem"
            exit!
          end
        end
      end
    end
    puts final_result

  end
end

include Automata
state_zero