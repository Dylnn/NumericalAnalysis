#!/usr/bin/env ruby -wKU

puts "Enter Tolerance:"
tolerance = gets.to_f

puts "Enter initial X:"
x0 = gets.to_f

puts "Enter number of iterations:"
num_iter = gets.to_i

puts "Enter function:"
function = gets.chomp
f = lambda{ |x|
  eval( function.gsub 'x', "#{x}" )
}

puts "Enter derivative function:"
delta_function = gets.chomp
df = lambda{ |x|  
  eval( delta_function.gsub 'x', "#{x}" )
}

f_x = f.call x0
df_x = df.call x0

counter = 0
error = tolerance + 1
puts "iter\tXn\t\tF(x)\t\tF'(x)\t\tError\n"
while error > tolerance && 
        ( not f_x == 0 ) &&
        (not df_x == 0) &&
        counter < num_iter do
  printf "%d\t%4f\t%4f\t%4f\t%4f\n", counter, x0, f_x, df_x, error
  x1 = x0 - f_x.fdiv( df_x )
  f_x = f.call x1
  df_x = df.call x1
  error = (x1 - x0).fdiv( x1 ).abs
  x0 = x1
  counter += 1
end
printf "%d\t%4f\t%4f\t%4f\t%4f\n", counter, x0, f_x, df_x, error
if f_x.zero?
  puts "x0= #{x0} is root"
elsif error < tolerance
  puts "x1= #{x1} is a root approximation with tolerance = #{tolerance}"
elsif is_x_root? df_x: df_x
  puts "x1= #{x1} it's possibly a multiple root"
else
  puts "operation failed in iteration##{num_iter}"
end