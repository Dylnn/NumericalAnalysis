#!/usr/bin/env ruby -wKU
def is_x_root? opt = {}
  if opt[:x0] == 0
    puts "x0 is a root"
    true
  elsif opt[:x1] == 0
    puts "x1=#{opt[:x1]} is a root"
    true
  end
end

puts 'Funtion in ruby terms:'
function = gets.chomp
f = lambda{ |x|
 eval function.gsub 'x', "#{x}"
}

puts 'Enter x0:'
x0 = gets.to_f

puts 'Enter delta'
delta = gets.to_f

puts  'Enter number of iterations:'
num_iter = gets.to_f

# evaluar funcion en x0
f_eval_x0 = f.call x0
# amenos que x0 no sea raiz haga
unless is_x_root? x0: f_eval_x0
  x1 = x0 + delta
  counter = 1
  f_eval_x1 = f.call x1
  # mientras f(x0) * f(x1) sea > 0
  # y el contador sea menor que el numero de iteraciones dado
  while f_eval_x0 * f_eval_x1 > 0 &&
      counter < num_iter do
    x0 = x1
    f_eval_x0 = f_eval_x1
    x1 = x0 + delta
    f_eval_x1 = f.call x1
  end
  # amenos que x1 no sea raiz haga
  unless is_x_root? x1: f_eval_x1
    # si la f(x0) * f(x1) < 0
    if f_eval_x0 * f_eval_x1 < 0
      puts "there is a root between [x0,x1] = [#{x0},#{x1}]"
    else
      puts "it fails in #{num_iter} iterations"
    end
  end
end

# <- comentarios
# pruebas
# (Math::E ** ((3*x) - 12)) + x * Math::cos(3*x) - (x**2) + 4
# there is a root between [x0,x1] = [2.0,3.0]