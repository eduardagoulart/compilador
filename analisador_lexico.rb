require_relative 'tokens'

module Automata
  def le_arquivo
    letras = []

    f = File.open('teste1.c', 'r')
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
    line = 0
    final_result = []
    tokens = []
    numero = []
    t = []
    matriz_final = []
    input = le_arquivo
    input.each do |char|
      if char.match(/[a-zA-Z]/)
        tokens << char
      else
        t << char
        if tokens.size > 0
          tokens = tokens.join
          final_result << state_two(tokens)
          matriz_final << [tokens, state_two(tokens), line]
          tokens = []
          if char == ',' or char == ')' or char == '(' or char == '=' or char == ';' or char == '+' or char == '-' or char == '>' or char == '<' or char == '<=' or char == '>=' or char == '*' or char == '/'
            final_result << Token::MY_HASH[char]
            matriz_final << [char, Token::MY_HASH[char], line]
          end
        elsif char == ',' or char == ';' or char == '[' or char == ']' or char == '(' or char == ')' or char == '{' or char == '}' or char == '-' or char == '+' or char == '=' or char == '>' or char == '<' or char == '<=' or char == '>=' or char == '*' or char == '/'
          if char == ';' or char == ',' or char == ')'
            numero = numero.join
            if numero.match(/[0-9]+[.][0-9]+/)
              final_result << :FLOAT_CONST
              matriz_final << [numero, :FLOAT_CONST, line]
            elsif numero.match(/[.]([0-9])+/)
              puts "Lexema não permitido"
              exit!
            elsif numero.match(/[0-9]+/)
              final_result << :INTEGER_CONST
              matriz_final << [numero, :INTEGER_CONST, line]
            end
            numero = []
          elsif char == '>'
            if input[input.index(char) + 1] == '='
              final_result << Token::MY_HASH['>=']
              next
            end
          end
          final_result << Token::MY_HASH[char]
          matriz_final << [char, Token::MY_HASH[char], line]
        elsif char.match(/[0-9]/) or char == '.' or char.match(';')
          numero << char
        elsif char.match(/\n/)
          line += 1
        else
          if !char.match(/\s/)
            puts "Lexema #{char} não pertencente a linguagem"
            exit!
          end
        end
      end
    end
    puts final_result
    return final_result, matriz_final

  end
end

include Automata
state_zero
# puts state_zero
