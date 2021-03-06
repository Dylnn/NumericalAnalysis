#!/usr/bin/env ruby -wKU

puts "Function in ruby terms:"
function = gets.chomp
f = lambda { |x|
  eval function.gsub 'x', "#{x}"
}

# xinf - (f(xinf)(xsup - xinf) / (f(xsup) - f(xinf)))
f_media = lambda do |x_infer, x_super|
  x_infer - ( f.call( x_infer ) * ( x_super - x_infer ) ).fdiv( f.call( x_super ) - f.call( x_infer ) )
end

puts "Enter the smaller x:"
x_infer = gets.to_f

puts "Enter the greater x:"
x_super = gets.to_f

puts "Enter the tolerancy:"
tolerancy = gets.to_f

puts "Enter number of iterations:"
num_iter = gets.to_f

# funcion evaluada en x_infer
f_eval_x_infer = f.call x_infer
# funcion evaluada en x_super
f_eval_x_super = f.call x_super

# si f(x_infer) es raiz haga
if f_eval_x_infer.zero?
  puts "x_infer= #{x_infer} is a root"
# de otro modo si f(x_super) es raiz haga
elsif f_eval_x_super.zero?
  puts "x_super= #{x_super} is a root"
# de otro modo si f(x_infer) * f(x_super) < 0 haga
elsif f_eval_x_infer * f_eval_x_super < 0
  # hallar la media entre x_infer y x_super
  x_media = f_media.call x_infer, x_super
  # funcion evaluada en x media
  f_eval_xm = f.call x_media
  # contador iteraciones
  counter = 1
  # calculo del error a base de la tolerancia
  error = tolerancy + 1
  # mientras que el error sea mayor que la tolerancia esperada haga y
  # que la funcion evaluada en la x media sea diferente de 0 y
  # el contador no sobrepase el numero de iteraciones dado haga
  print "iter\txInf\t\txSup\t\txMed\t\tf(xMed)\t\tError\n"
  while error > tolerancy &&
          f_eval_xm != 0 &&
          counter < num_iter
      printf "%d\t%4f\t%4f\t%4f\t%4f\t%4f\n", counter, x_infer, x_super, x_media, f_eval_xm, error
      # si f(x_infer) * f(x_super) es menor que 0 hubo cambio de signo
      # remplazar la x superior por la x media, de lo contrario
      # remplazar la x inferior por la x media
      if f_eval_x_infer * f_eval_xm < 0
        x_super = x_media
        f_eval_x_super = f_eval_xm
      else
        x_infer = x_media
        f_eval_x_infer = f_eval_xm
      end
      # guardar la x media en un auxiliar
      x_aux = x_media
      # recalcular la x media
      x_media = f_media.call x_infer, x_super
      # evaluar la funcion en x media
      f_eval_xm = f.call x_media
      # calular el error obtenido
      error = (x_media - x_aux).abs
      counter += 1
  end
  printf "%d\t%4f\t%4f\t%4f\t%4f\t%4f\n", counter, x_infer, x_super, x_media, f_eval_xm, error
  if f_eval_xm.zero?
      puts "xMed= #{x_media} is a root"
  elsif error < tolerancy
      puts "xMed= #{x_media} is a root aproximation with tolerancy = #{tolerancy}"
  else
      puts "it fails at the iteration ##{num_iter}"
  end
else
    puts "improper range"
end
