require_relative 'tokens'

module Teste
  def construtor_lexico
    @concatena_palavra = []
    @concatena_numero = []
    @concatena_simbolos = []
    @tokens = []
    @matriz_final = []
    @index = 0
    @linha = 0
  end

  def le_arquivo
    construtor_lexico
    @letras = []

    f = File.open('teste16.c', 'r')
    f.each_char do |char|
      @letras << char
    end
    @letras << :EOF
    f.close
  end
  
  def automato  
    if @letras[@index].match(/[a-zA-Z]/)
      @tokens << state_one() 
      @concatena_palavra = []
    elsif @letras[@index].match(/[0-9]/)
      @tokens << state_three()
      @concatena_numero = []
    elsif @letras[@index].match(/\s/)
        if @letras[@index].match(/\n/)
          @linha += 1
        end
        @index += 1
    elsif @letras[@index].match(/[[:punct:]]/)
      @tokens << state_five()
      @concatena_simbolos = []
      @index += 1                      
    else
      puts @letras[@index]
      puts "Carctere #{@letras[@index]} não encontrado na linguagem"
      exit!
    end
    if @letras[@index] == :EOF
      puts "Analise léxica concluída!!"
      return
    end
    automato
    return @tokens, @matriz_final
  end
  
  def state_one()
    if @letras[@index].match(/[a-zA-Z0-9_]/)
      @concatena_palavra << @letras[@index]
      @index += 1
      state_one()
    else
      @concatena_palavra = @concatena_palavra.join
      return state_two()
    end
  end

  def state_two()
    if Token::MY_HASH[@concatena_palavra]
      @matriz_final << [@concatena_palavra, Token::MY_HASH[@concatena_palavra], @linha]
      return Token::MY_HASH[@concatena_palavra]
    else
      @matriz_final << [@concatena_palavra, :ID, @linha,'/']
      return :ID
    end
  end

  def state_three()
    if @letras[@index].match(/[0-9]/)
      @concatena_numero << @letras[@index]
      @index += 1
      state_three()
    elsif @letras[@index] == '.'
      @concatena_numero << @letras[@index]
      state_for()
    else
      @concatena_numero.join #join para adicionar a tabela de valor
      @matriz_final << [@concatena_numero, :INTEGER_CONST,'linha' ,@linha,'/']
      return :INTEGER_CONST
    end
  end

  def state_for()
    @index += 1
    if @letras[@index].match(/[0-9]/)
      @concatena_numero << @letras[@index]
      state_for()
    else
      @concatena_numero.join
      @matriz_final << [@concatena_numero, :FLOAT_CONST, 'linha', @linha,'/']
      return :FLOAT_CONST
    end
  end

  def state_five()
    @concatena_simbolos << @letras[@index]
    if @letras[@index+1] == '='
      @index += 1
      @concatena_simbolos << @letras[@index]
      @concatena_simbolos = @concatena_simbolos.join
      if Token::MY_HASH[@concatena_simbolos]
        @matriz_final << [@concatena_simbolos, Token::MY_HASH[@concatena_simbolos], @linha]
        return Token::MY_HASH[@concatena_simbolos]
      else
        puts "Carctere #{@letras[@index-1]}#{@letras[@index]} não encontrado na linha"
        exit!
      end
    end
    @matriz_final << [@letras[@index], Token::MY_HASH[@letras[@index]], @linha]
    return Token::MY_HASH[@letras[@index]]
  end
end

# include Teste
# le_arquivo
# automato