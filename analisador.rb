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
        reservados << Token::MY_HASH[valor]
        puts valor
      elsif valor.match(/[+-]?[0-9][.][0-9]/)
        reservados << :FLOAT_CONT

      elsif valor.match(/[+-]?[0-9]/)
        reservados << :INTEGER_CONST

      elsif valor.match(/[a-zA-Z]/)
        reservados << :ID
      elsif valor.match(/\s/) or valor.match(/(.|\s)*/)
      else
        if Token::MY_HASH[valor]
          puts "chega aqui"
          reservados << Token::MY_HASH[valor]
        else
          puts reservados
          puts "#{valor} - Caractere inválido na linguagem"
          exit
        end
      end
    end
    puts reservados.join(" ")
  end
end

# include Lexema
# tokeniza

module AnalisadorLexico
  def arquivo
    reservados = []
    letras = []
    t = []
    f = File.open('soma.c', 'r')

    f.each_char do |char|
      if char.match(/\w/)
        letras << char
      elsif !char.match(/w/)
        if letras.size > 0
          # puts "char - #{char}, tipo"
          letras = letras.join
          t << char
          if Token::MY_HASH[letras]
            reservados << [Token::MY_HASH[letras], letras]
          elsif char.match(/[+-]?[0-9][.][0-9]/)
            reservados << [:FLOAT_CONT, char]
          elsif char.match(/[+-]?[0-9]/)
            reservados << [:INTEGER_CONST, char]
          elsif !char.match(/\s/)
            puts char
            reservados << [Token::MY_HASH[t], t]
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

    puts reservados.join.split(" ")
    f.close

  end
end

# include AnalisadorLexico
# arquivo

module Teste
  def leitura_arquivo
    letras = []
    reservados = []
    numero = []
    t=[]
    file = File.open('soma.c', 'r')

    file.each_char do |char|
      if char.match(/[a-zA-Z]/)
        letras << char
      else
        t << char
        if letras.size > 0
          letras = letras.join
          if Token::MY_HASH[letras]
            reservados << Token::MY_HASH[letras]
          elsif letras.match(/\w/)
            reservados << :ID
          end
          letras = []
        else
          if t
            t.each do |char|
              if Token::MY_HASH[char]
                reservados << Token::MY_HASH[char]
              elsif char.match(/[0-9]/)
                numero << char
              end
            end
            t = []
          end
        end
        # @todo: concatenar os numeros
        if numero.size > 0
          numero = numero.join
          puts "numero - #{numero}"
          if numero.match(/([0-9])+[.]([0-9])+/)
            reservados << [:FLOAT_CONT, char]
            numero = []
          elsif numero.match(/([0-9])+/)
            reservados << :INTEGER_CONST
            numero = []
          end
        end

      end
    end
    t.each do |char|
      if Token::MY_HASH[char]
        reservados << Token::MY_HASH[char]
      end
    end
    puts reservados
  end
end

include Teste
leitura_arquivo