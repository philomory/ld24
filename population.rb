module LD24
  class Population
    attr_reader :organisms
    attr_accessor :environment
    
    def initialize(environment)
      @environment = environment
      @organisms = []
      baseline = setup_initial_genotype
      20.times do
        g = Genotype.new
        g.members.each {|m| g[m] = baseline[m] - 3 + rand(7)}
        Organism.new(self,g)
      end
    end
    
    
    def setup_initial_genotype
      g = Genotype.new
      g.members.each {|m| g[m] = 18 + rand(5)}
      g.thermal_center = @environment.temperature + rand(3) - 1
      g
    end
    
    def feed
      @organisms.each {|o| o.food_search }
      hungry = @organisms.dup
      search_array = @organisms.sort_by {|o| o.food_search_success}
      while @environment.food > 0 and organism = search_array.pop
        if true #organism.food_search_success + rand(@environment.food.. > 50
          organism.feed
          hungry.delete(organism)
          if organism.food_search_success > 0
            search_array << organism
            search_array.sort_by! {|o| o.food_search_success} # Inefficient, but fix it later
          end 
        end
      end
      hungry.each {|o| puts "#{o} went hungry today!" if SHOW_HUNGRY }
    end
    
    def stress
      @organisms.each {|o| o.stress }
    end
    
    def predation
      @environment.predator.population.times do
        prey = @organisms.sample
        if prey
          @environment.predator.hunt(prey)
        else
          exit
        end
      end
    end
    
    def reproduce
      @organisms.each {|o| o.reproduce_if_able }
    end
    
  end
end