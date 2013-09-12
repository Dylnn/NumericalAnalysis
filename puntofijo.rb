#!/usr/bin/env ruby -wKU

puts 'Enter f(x):'
function_fx = gets.chomp
f = lambda{ |x|
  eval function_fx.gsub 'x', "#{x}"
}

puts 'Enter g(x):'
function_gx = gets.chomp
g = lambda { |x| 
 eval function_gx.gsub 'x', "#{x}"
}

puts 'Tolerance:'
tolerance = gets.to_f

puts 'Enter initial x:'
prev_x = gets.to_f

puts 'Iterations'
num_iter = gets.to_i

f_eval_x = f.call prev_x
counter = 0
error = tolerance + 1
x_n = 0
puts "iter\tXn\t\tF(Xn)\t\tError\n"
while f_eval_x != 0 &&
        error > tolerance &&
        counter < num_iter do
    printf "%d\t%4f\t%4f\t%4f\n", counter, prev_x, f_eval_x, error
    x_n = g.call prev_x
    f_eval_x = f.call x_n
    error = (x_n - prev_x).fdiv(x_n).abs
    prev_x = x_n
    counter += 1
end
printf "%d\t%4f\t%4f\t%4f\n", counter, x_n, f_eval_x, error
if f_eval_x.zero?
  puts "xn= #{prev_x} is root"
elsif error < tolerance
  puts "xn= #{prev_x} is a root approximation with tolerance= #{tolerance}"
else
  puts "the method failed on iteration ##{counter}"
end

# (x**2 - 5*x - Math::E**x)
# (x**2 - Math::E**x)/5

# ( x * (Math::E ** x) ) - ( x ** 2 ) - ( 4 * x ) - 3
# ( ( x * (Math::E ** x) ) - ( x**2 ) - 3 ) / 5