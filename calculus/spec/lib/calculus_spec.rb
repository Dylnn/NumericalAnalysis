require "spec_helper"
require "calculus"
describe Calculus do
  context "Incremental search" do
      it "returns [2,3]" do
        expect( Calculus.incremental_search( -10, 1, 20, "(E ** (3*x - 12)) + (x * Math::cos(3 * x)) - x ** 2 + 4" ) ).to eql( [2,3] )
      end
  end

  context "bisection" do
      it "returns complete answer" do
        expect( Calculus.bisection( [0.5, 1.5], "2+cos(E**x-2)-E**x")).to eql( 1.007623971614521 )
      end
      it "returns truncated answer" do
        expect( Calculus.bisection( [0.5, 1.5], "2+cos(E**x-2)-E**x", 4 ) ).to eql( 1.0076 )
      end

      describe "Incremental Search with Bisection " do
        let(:result) { Calculus.incremental_search( -10, 1, 20, "(E ** (3*x - 12)) + (x * Math::cos(3 * x)) - x ** 2 + 4" ) }
        it "returns a root aproximation with 5 decimals" do
          expect( Calculus.bisection( result, "(E ** (3*x - 12)) + (x * Math::cos(3 * x)) - x ** 2 + 4", 5 ) ).to eql(2.36953)
        end
        it "returns a complete root aproximation" do
          expect( Calculus.bisection( result, "(E ** (3*x - 12)) + (x * Math::cos(3 * x)) - x ** 2 + 4" ) ).to eql(2.3695294577046297)
        end
        describe "number of decimals as Float numbers" do
          it "returns a complete root aproximation" do
            expect( Calculus.bisection( result, "(E ** (3*x - 12)) + (x * Math::cos(3 * x)) - x ** 2 + 4", 5.6 ) ).to eql(2.3695294577046297)
          end
        end
      end
  end

  context "false rule" do

  end

  context "fixed point" do

  end
end