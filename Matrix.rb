#!/usr/bin/env ruby -wKU
require "awesome_print"
class Matrix
      attr_accessor :matriz,:n,:m
      attr_reader :simetrica
      def initialize(n,m,matriz = nil)
            @n = n
            @m = m
            if matriz
                  @matriz = matriz
            else
                  @matriz = Array.new(n){ Array.new(m) }
                  entrar_datos
                  @transpuesta = nil
                  @simetrica = nil
                  @t_superior = nil
                  transpuesta
                  simetrica?
            end
            self
      end

      def entrar_datos
            # 0.upto(@n - 1) do |i|
            #       0.upto(@m - 1) do |j|
            #              puts "ingrese datos:"
            #              dato = gets.to_i
            #              @matriz[i][j] = dato
            #       end
            # end
            @matriz = [ [14,6,-2,3,12], [3,15,2,-5,32], [-7,4,-23,2,-24], [1,-3,-2,16,14] ]
      end

      def self.imprimir matrix
            puts "Matriz Original:"
            0.upto(matrix.n - 1) do |i|
                  0.upto(matrix.m - 1) do |j|
                        print "#{matrix.matriz[i][j]} "
                  end
                  puts ""
            end
      end

      def equals? matrix
            if  (@n != matrix.n) || (@m != matrix.m)
                  return false
            end
            0.upto(@n - 1) do |i|
                  0.upto(@m - 1) do |j|
                        unless @matriz[i][j] == matrix.matriz[i][j]
                              return false
                        end
                  end
            end
            true
      end

      def multiplicar matrix
            unless @m == matrix.n
                  puts "No se puede multiplicar, las columnas de A tienen que
                  tener la misma longitud que las filas de B"
                  return
            end
            temp = Array.new(@n,0) { Array.new(matrix.m,0) }
            0.upto(@n - 1) do |i|
                  matrix.m.times do |j|
                        0.upto(@m - 1) do |k|
                              temp[i][j] += @matriz[i][k] * matrix.matriz[k][j]
                        end
                  end
            end
            Matrix.new(temp.size,temp[0].size,temp)
      end

      def suma matrix
            unless @m == matrix.m and @n == matrix.n
                  puts "No se puede sumar, las longitudes tienen que ser iguales"
                  return
            end
            temp = Array.new(@n,0) { Array.new(@m,0) }
            0.upto(@n - 1) do |i|
                  0.upto(@m - 1) do |j|
                        temp[i][j] += @matriz[i][j] + matrix.matriz[i][j]
                  end
            end
            Matrix.new(temp.size,temp[0].size,temp)
      end

      def transpuesta
            unless @transpuesta
                   temp = Array.new(@m){ 
                          Array.new(@n) 
                   }
                  0.upto(@m - 1) do |i|
                          0.upto(@n - 1) do |j|
                                temp[i][j] = @matriz[j][i]
                          end
                  end
                  @transpuesta = Matrix.new(temp.size,temp[0].size,temp)
            end
            @transpuesta
      end

      def simetrica?
            return @simetrica unless @simetrica.nil?
            unless @transpuesta
                  transpuesta
            end
            if matriz.equal? @transpuesta
                  0.upto(@n - 1) do |i|
                        0.upto(@m - 1) do |j|
                              unless matriz[i][j] == matriz[j][i]
                                    return @simetrica = false
                              end
                        end
                  end
                  return @simetrica = true
            end
            @simetrica = false
      end

      def gauss_simple pos_i = 0, pos_j = 0
            return if pos_i >= @n - 1 || pos_j >= @m - 1
            unless @matriz[pos_i][pos_j].zero?
                  temp = pos_i
                  while temp < @n - 1 do
                          multiplicador = (@t_superior.matriz[temp + 1][pos_j]).fdiv(@t_superior.matriz[pos_i][pos_j])
                          vector1 = @t_superior.matriz[pos_i].map { |value| value * multiplicador }
                          @t_superior.matriz[temp + 1].map! { |value| value - vector1.shift }
                          temp += 1
                  end
            end
            gauss_simple pos_i + 1, pos_j + 1
      end

      def triangular_superior
            if @t_superior.nil?
                   @t_superior ||= self.clone
                   gauss_simple
            end
            @t_superior
      end

      def triangular_inferior
        
      end
end

test = Matrix.new 4, 5
Matrix.imprimir test
Matrix.imprimir test.transpuesta
Matrix.imprimir test.triangular_superior
