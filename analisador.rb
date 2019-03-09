letras = []

f = File.open('soma.txt', 'r')
f.each_char do |char|
  letras.append(char)
end

f.close
letras = letras.join(" ")
puts letras
