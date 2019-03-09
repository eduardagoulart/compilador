letras = []

f = File.open('soma.c', 'r')
f.each_char do |char|
  letras.append(char)
end
f.close

puts letras[0]
letras = letras.join
puts letras

puts letras[0]
