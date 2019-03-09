require_relative 'tokens'

letras = []

f = File.open('soma.c', 'r')
f.each_char do |char|
  letras << char
end
f.close

puts letras[0]
letras = letras.join
puts letras

puts letras[0]
puts Token::MY_HASH
