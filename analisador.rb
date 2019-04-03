require_relative 'tokens'

module Teste
  def leitura_arquivo
    letras = []
    reservados = []
    numero = []
    t = []
    num = " "
    t = []
    flag = false
    file = File.open('soma.c', 'r')

    file.each_char do |char|
      if char =~ /[a-zA-Z]/
        letras << char
      else
        t << char
        if letras.size > 0
          letras = letras.join
          if Token::MY_HASH[letras]
            reservados << Token::MY_HASH[letras]
          elsif letras =~ /\w/
            reservados << :ID
          end
          letras = []
        else
          if t
            t.each_with_index do |char|
              if Token::MY_HASH[char]
                reservados << Token::MY_HASH[char]
                flag = true if Token::MY_HASH[char].match("PCOMMA")
                numero = []
                num.clear
              elsif char =~ /[0-9]/
                numero << char
              elsif char =~ /\./
                numero << char

              end
            end
            t = []
          end
        end
        if numero.size > 0
          puts numero
          numero = numero.join
          puts "numero - #{numero.size} - #{numero}"
          if numero.match(/([0-9])+[.]([0-9])+/)
            reservados << [:FLOAT_CONT, char]
            num << numero
            numero = num.clone
            if numero =~ /([0-9])+[.]([0-9])+/
              reservados << :FLOAT_CONST
              numero = []
              num.clear
            elsif numero =~ /([0-9])+/
              if flag
                reservados << :INTEGER_CONST
              end
              numero = []
            end
          end

        end
      end
      t.each do |char|
        if Token::MY_HASH[char]
          # @todo: concatenar os numeros
          reservados << Token::MY_HASH[char]
        end
      end
      puts reservados
    end
  end
end


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
            # puts "#{numero} pcomma"
            numero = numero.join
            # puts numero
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
          puts char

          "Lexema #{char} não pertencente a linguagem"
          # exit!
        end
      end
    end
    puts final_result

  end
end

include Automata
state_zero