module LD24
  class Adversity
    class PredatorStrength < Adversity
      def initialize(level)
        @level = level
        @name = "Predator Evolution: Strength"
        @description = "The predators will become #{@level*25}% stronger."
      end

      def apply(population)
        predator = population.environment.predator
        puts predator.strength
        puts predator.strength * (1+(level/4.0))
        predator.strength = (predator.strength * (1+(level/4.0))).to_i
        puts "The predators are now #{@level*25}% stronger."
        puts "The predators now have a strength of #{population.environment.predator.strength}."
      end
    end
  end
end