#!/usr/bin/env ruby -wKU
def is_x_root? opt = {}
  if opt[:xa] == 0
    puts "x0 is a root"
    true
  end
end
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

tolerancy = gets.to_f
puts 'Enter xa:'
x_a = gets.to_f
num_iter = gets.to_i

f_eval_x = f.call x_a
counter = 0
error = tolerancy + 1
x_n = 0
while f_eval_x != 0 &&
  error > tolerancy &&
  counter < num_iter
    puts "iter = #{counter}\n xn=#{x_n}\n f(xn)=#{f_eval_x}\n Error=#{error}\n\n"
    x_n = g.call x_a
    f_eval_x = f.call x_n
    error = (x_n - x_a).abs
    x_a = x_n
    counter += 1
end

if f_eval_x == 0
  puts "x_a=#{x_n} is root"
elsif error < tolerancy
  puts "x_a is a root aproximation with tolerancy= #{tolerancy}"
else
  puts "the method failed on iteration ##{counter}"
end

# (x**2 - 5*x - Math::E**x)
# (x**2 - Math::E**x)/5