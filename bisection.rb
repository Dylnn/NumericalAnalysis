#!/usr/bin/env ruby -wKU

def is_x_root? opt = {}
  if opt[:xi] == 0
    puts "x_infer is a root"
    true
  elsif opt[:xs] == 0
    puts "x_super=#{opt[:x_super]} is a root"
    true
  elsif opt[:xm] == 0
    puts "x_media=#{opt[:x_media]} is a root"
    true
  end
end

puts "Function in ruby terms:"
funcion = gets.chomp
f = lambda { |x|
  eval function.gsub 'x', "#{x}"
}

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

# a menos que f(x_infer) no sea raiz haga
unless is_x_root? xi: f_eval_x_infer
  # a menos que f(x_super) no sea raiz haga
  unless is_x_root? xs: f_eval_x_super
    # si f(x_infer) * f(x_super) < 0 haga
    if f_eval_x_infer * f_eval_x_super < 0
      # hallar la media entre x_infer y x_super
      x_media = (x_infer + x_super).fdiv 2
      # funcion evaluada en x media
      f_eval_xm = f.call x_media
      # contador iteraciones
      counter = 1
      # calculo del error a base de la tolerancia
      error = tolerancy + 1
      # mientras que el error sea mayor que la tolerancia esperada haga y
        # que la funcion evaluada en la x media sea diferente de 0 y
        # el contador no sobrepase el numero de iteraciones dado haga
      print "| i \tx_inf \t\tx_sup \t\tx_med \t\tf(x_med) \t\tError|\n"
      while error > tolerancy &&
        f_eval_xm != 0 &&
        counter < num_iter
          puts "#{counter} \t#{x_infer} \t\t#{x_super} \t\t#{x_media} \t\t#{f_eval_xm} \t\t#{error}"
          # si f(x_infer) * f(x_super) es menor que 0 hubo cambio de signo
          # remplazar la x superior por la x media, de lo contrario
          # remplazar la x inferior por la x media
          if f_eval_x_infer * f_eval_x_super < 0
            x_super = x_media
            f_eval_x_super = f_eval_xm
          else
            x_infer = x_media
            f_eval_x_infer = f_eval_xm
          end
          # guardar la x media en un auxiliar
          x_aux = x_media
          # recalcular la x media
          x_media = (x_infer + x_super).fdiv 2
          # evaluar la funcion en x media
          f_eval_xm = f.call x_media
          # calular el error obtenido
          error = (x_media - x_aux).abs
          counter += 1
      end
      unless is_x_root? xm: f_eval_xm
        if error < tolerancy
          puts "x media is a root aproximation,with tolerancy = #{tolerancy}"
        else
          puts "it fails at the iteration ##{num_iter}"
        end
      end
      else
        puts "improper range"
    end
  end
end
