require "spec_helper"
require "calculus"
describe Calculus do
  context "Incremental search" do
      it "returns [-2,-1]" do
        expect(
               Calculus.incremental_search( -10, 1, "(E ** (3*x - 12)) + (x * cos(3 * x)) - (x ** 2) + 4" )
               ).to eql( [-2,-1] )
      end
      it "returns [2,3]" do
        expect(
               Calculus.incremental_search( 0, 1, "(E ** (3*x - 12)) + (x * cos(3 * x)) - (x ** 2) + 4" )
               ).to eql( [2,3] )
      end
  end

  context "bisection" do
      it "returns complete answer" do
        expect(
               Calculus.bisection( [0.5, 1.5], "2+cos(E**x-2)-E**x")
               ).to eql( 1.007623971614521 )
      end
      it "returns truncated answer" do
        expect(
               Calculus.bisection( [0.5, 1.5], "2+cos(E**x-2)-E**x", 4 )
               ).to eql( 1.0076 )
      end

      describe "Incremental Search with Bisection " do
        let(:cal) { double("Calculus", incremental_search: [2,3]) }
        it "returns a root aproximation with 5 decimals" do
          expect(
                 Calculus.bisection( cal.incremental_search, "(E**(3*x-12))+(x*cos(3*x))-x**2+4", 5 )
                 ).to eql(2.36953)
        end
        it "returns a complete root aproximation" do
          expect(
                 Calculus.bisection( cal.incremental_search, "(E ** (3*x - 12)) + (x * cos(3 * x)) - x ** 2 + 4" )
                 ).to eql(2.3695294577046297)
        end
        describe "number of decimals as Float numbers" do
          it "returns a complete root aproximation" do
            expect(
                   Calculus.bisection( cal.incremental_search, "(E ** (3*x - 12)) + (x * cos(3 * x)) - x ** 2 + 4", 5.6 )
                   ).to eql(2.3695294577046297)
          end
        end
      end
  end

  context "false rule" do
    describe "bisection and false rule" do
      let(:cal) { double('Calculus', bisection: 2.3695294577046297, incremental_search: [2,3]) }
      it "shouldn't be more precise than bisection" do
        expect(
               Calculus.false_rule( cal.incremental_search, "(E ** (3*x - 12)) + (x * cos(3 * x)) - x ** 2 + 4" )
               ).to be >= cal.bisection
      end
    end
  end

  context "fixed point" do
    it "should return a root aproximation" do
      expect(
             Calculus.fixed_point( "x * E**x - x**2 - 5*x - 3", "(x * E**x - x**2 -3).fdiv( 5 )", -0.5 )
             ).to eql (-0.7998378284476866)
      expect(
             Calculus.fixed_point( "(x**4)-(3*(x**2))-3", "((3*x**2)+3)**(1.fdiv(4))", 1 )
             ).to eql (1.947122966622019)
    end
  end
end