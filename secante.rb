#!/usr/bin/env ruby -wKU
def is_x_root? opt = {}
  if opt[:f_x] == 0
    true
  elsif opt[:f_x1] == 0
    true
  end
end

puts "Enter Tolerance:"
tolerance = gets.to_f

puts "Enter initial X:"
x0 = gets.to_f

puts "Enter final X:"
x1 = gets.to_f

puts "Enter number of iterations:"
num_iter = gets.to_i

puts "Enter function:"
function = gets.chomp
f = lambda{ |x|
  eval function.gsub 'x', "#{x}"
}

def display c, x, fx, e
  printf "%d\t%4f\t%4f\t%4f\n", c, x, fx, e
end

f_x0 = f.call x0
den = 0
error = 0
puts "iter\tXn\t\tF(x)\t\tError\n"
if is_x_root? f_x: f_x0
  puts "x0= #{f_x} is root"
else
  f_x1 = f.call x1
  counter = 0
  error = tolerance + 1
  den = f_x1 - f_x0
  while error > tolerance &&
          ( not f_x1 == 0 ) &&
          ( not den == 0 ) &&
          counter < num_iter do
      display counter, x0, f_x0, error
      x2 = x1 - ( f_x1  * ( x1 - x0 ).fdiv( den ) )
      error = ( x2 - x1 ).fdiv( x2 ).abs
      x0 = x1
      f_x0 = f_x1
      x1 = x2
      f_x1 = f.call x1
      den = f_x1 - f_x0
      counter += 1
  end
  display counter, x0, f_x0, error
  if is_x_root? f_x1: f_x1
    puts "x1= #{f_x1} is root"
  elsif error < tolerance
    puts "x1= #{x1} is a root approximation with tolerance = #{tolerance}"
  elsif den.zero?
    puts "there's possibly a multiple root"
  else
    puts "operation failed in iteration##{num_iter}"
  end
end