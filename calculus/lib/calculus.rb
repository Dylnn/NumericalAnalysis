require "calculus/version"
$SAFE = 1
include Math
module Constants
  TOLERANCE = 1e-10
  X0 = 0
  X1 = 1
  ERROR = TOLERANCE + 1
  MAX_ITERATIONS = 100
  DONT_SCAPE = %r(\A\(*(\w+)((\s|\w|\)|\()*[+-\/\*](\s|\w|\)|\()*)*\z)
end
module Calculus
  @f = lambda { |function, x|
    if function =~ Constants::DONT_SCAPE
      function.untaint
      eval function.gsub( 'x', "(#{x})" )
    else
      raise "Illegal"
    end
  }
  class << self
    include Constants

    def rounded num, decimals
      if decimals.zero? || !decimals.integer?
        num
      else
        num.round( decimals.abs )
      end
    end

    def incremental_search x0, delta, function
        f_eval_x0 = @f.call( function, x0)
        unless f_eval_x0.zero?
          x1 = x0 + delta
          counter = 1
          f_eval_x1 = @f.call( function, x1 )
          while f_eval_x0 * f_eval_x1 > 0 &&
              counter < MAX_ITERATIONS
            x0 = x1
            f_eval_x0 = f_eval_x1
            x1 = x0 + delta
            f_eval_x1 = @f.call( function, x1 )
            counter += 1
          end
          if x1.zero? || x1 <= TOLERANCE
            return x0, x1
          elsif f_eval_x0 * f_eval_x1 < 0
            return x0, x1
          end
        end
        x0
    end

    def bisection range, function, decimals = 0 # range is [x0, x1], from x0 to x1
        iterations = (log10(range[X1] - range[X0]) - log10(TOLERANCE)).fdiv( log10( 2 ) ).ceil
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
          error = ERROR
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

    def fixed_point function_fx, function_gx, initial_x
      x0 = initial_x
      f_eval_x = @f.call( function_fx, x0 )
      counter = 0
      error = ERROR
      x_n = 0
      while f_eval_x != 0 &&
              error > TOLERANCE &&
              counter < MAX_ITERATIONS
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

    def false_rule range, function
      iterations = (log10(range[X1] - range[X0]) - log10(TOLERANCE)).fdiv( log10( 2 ) ).ceil
      f_media = lambda do |x_infer, x_super|
        x_infer - ( @f.call( function, x_infer ) * ( x_super - x_infer ) ).fdiv( @f.call( function, x_super ) - @f.call( function, x_infer ) )
      end
      x0, x1 = range[X0], range[X1]
      f_eval_x_infer = @f.call( function, x0 )
      f_eval_x_super = @f.call( function, x1 )
      if f_eval_x_infer.zero?
        return x0
      elsif f_eval_x_super.zero?
        return x1
      elsif f_eval_x_infer * f_eval_x_super < 0
        x_media = f_media.call( x0, x1 )
        f_eval_xm =  @f.call( function, x_media )
        counter = 1
        error = ERROR
        while error > TOLERANCE &&
                f_eval_xm != 0 &&
                counter < iterations
          if f_eval_x_infer * f_eval_xm < 0
            x1 = x_media
            f_eval_x_super = f_eval_xm
          else
            x0 = x_media
            f_eval_x_infer = f_eval_xm
          end
          x_aux = x_media
          x_media = f_media.call( x0, x1 )
          f_eval_xm = @f.call( function, x_media )
          error = ( x_media - x_aux ).abs
          counter += 1
        end
        if f_eval_xm.zero? || error <=  TOLERANCE
          return x_media
        else
          raise "root not found"
        end
      end
      raise "improper range"
    end
  end
end
