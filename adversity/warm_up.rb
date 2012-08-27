module LD24
  class Adversity
    class WarmUp < Adversity
      def initialize(level)
        @level = level
        @name = "Climate Change: Warmer"
        @description = "The temperature will go up by about #{(2**@level)*3/2} degrees."
      end
      
      def apply(population)
        factor = rand(2**level..2**(level+1))
        population.environment.temperature += factor
        puts "The temperature rose #{factor} degrees."
        puts "The new temperature is #{population.environment.temperature}"
      end
    end
  end
end