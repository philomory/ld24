module LD24
  class Adversity
    class PredatorBoom < Adversity
      def initialize(level)
        @level = level
        @name = "Predator Boom"
        @description = "The predator population will increase by as many as #{@level}."
      end

      def apply(population)
        factor = rand(1..level)
        population.environment.predator.population += factor
        puts "#{factor} new predators have moved in."
        puts "There are now #{population.environment.predator.population} predators in the area."
      end
    end
  end
end
