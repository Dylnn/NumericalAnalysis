require "calculus/version"

include Math
module Constants
  TOLERANCE = 1e-10
  X0 = 0
  X1 = 1
end
module Calculus
  @f = lambda { |function, x|  eval function.gsub( 'x', "#{x}" ) }
  class << self
    include Constants

    def rounded num, decimals
      if decimals.zero? || !decimals.integer?
        num
      else
        num.round decimals.abs
      end
    end

    def incremental_search x0, delta, iterations, function
        f_eval_x0 = @f.call( function, x0)
        unless f_eval_x0.zero?
          x1 = x0 + delta
          counter = 1
          f_eval_x1 = @f.call( function, x1 )
          while f_eval_x0 * f_eval_x1 > 0 &&
              counter < iterations
            # printf "%d\t%4f\t%4f\t%4f\t%4f\n", counter, x0, x1, f_eval_x0, f_eval_x1
            x0 = x1
            f_eval_x0 = f_eval_x1
            x1 = x0 + delta
            f_eval_x1 = @f.call( function, x1 )
            counter += 1
          end
          if x1.zero? || x1 <= TOLERANCE
            return x1
          elsif f_eval_x0 * f_eval_x1 < 0
            return x0, x1
          end
        end
        x0
    end

    def bisection range, function, decimals = 0 # range is [x0, x1], from x0 to x1
        iterations = (log10(range[X1] - range[X0]) - log10(TOLERANCE)).fdiv( log10( 2 ) )
        x_infer, x_super = range
        f_eval_x_infer = @f.call( function, x_infer )
        f_eval_x_super = @f.call( function, x_super )
        if f_eval_x_infer.zero?
          return rounded( x_infer, decimals )
        elsif f_eval_x_super.zero?
          return rounded( x_super, decimals )
        elsif f_eval_x_infer * f_eval_x_super < 0
          x_media = (x_infer + x_super).fdiv 2
          f_eval_xm = @f.call( function, x_media )
          counter = 1
          error = TOLERANCE + 1
          while error > TOLERANCE &&
            f_eval_xm != 0 &&
            counter < iterations
            if f_eval_x_infer * f_eval_xm < 0
              x_super, f_eval_x_super = x_media, f_eval_xm
            else
              x_infer, f_eval_x_infer = x_media, f_eval_xm
            end
            x_aux = x_media
            x_media = (x_infer + x_super).fdiv 2
            f_eval_xm = @f.call( function, x_media )
            error = (x_media - x_aux).abs
            counter += 1
          end
          if f_eval_xm.zero? || error < TOLERANCE
            return rounded( x_media, decimals )
          else
            raise "not root found"
          end
        end
        raise "improper range"
    end

    def fixed_point function_fx, function_gx, initial_x, iterations
      x0 = initial_x
      f_eval_x = @f.call( function_fx, x0 )
      counter = 0
      error = TOLERANCE + 1
      x_n = 0
      while f_eval_x != 0 &&
              error > TOLERANCE &&
              counter < iterations
        x_n = @f.call( function_gx, x0 )
        f_eval_x = @f.call( function_fx, x_n )
        error = ( x_n - x0 ).fdiv( x_n ).abs
        x0 = x_n
        counter += 1
      end
      if f_eval_x.zero? || error <= TOLERANCE
        x0
      else
        raise "root not found"
      end
    end

    def false_rule range, iterations
      x0, x1 = range[X0], range[X1]
    end
  end
end
