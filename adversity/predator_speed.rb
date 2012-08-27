module LD24
  class Adversity
    class PredatorSpeed < Adversity
      def initialize(level)
        @level = level
        @name = "Predator Evolution: Speed"
        @description = "The predators will become #{@level*25}% faster at #{level} movement type#{level == 1 ? "" : "s"}."
      end

      def apply(population)
        types = [:running,:climbing,:swimming,:jumping].sample(@level)
        types.each {|t| population.environment.predator[t] = (population.environment.predator[t] * (1+(@level/4.0))).to_i }
        puts "The predators are now #{@level*25}% faster at #{types.join(", ").reverse.sub(/,/, 'dna ').reverse}."
      end
    end
  end
end