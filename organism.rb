require 'delegate'
require 'faker'
module LD24
  class Organism < DelegateClass(Genotype)
    attr_reader :food_search_success, :name
    
    def initialize(population,genotype)
      @name = "#{Faker::Base.bothify("??###")} \"#{Faker::Name.first_name}\""
      @population = population
      @environment = @population.environment
      @genotype = genotype
      @food_search_success = 0
      @nutrition = 30
      @population.organisms << self
      super(@genotype)
    end
    
    def to_s
      @name
    end
    
    def inspect
      self.to_s
    end
    
    def food_search
      @food_search_success = (
        smell * 0.5 * rand +
        visual_acuity * 0.3 * rand +
        hearing * 0.2 * rand
      ).floor * [((@environment.food - 100) / 100), 1].max
    end
    
    def feed
      found_food = [@environment.food,rand(6)+rand(5)+1].min
      @nutrition += found_food
      @environment.food -= found_food
      puts "#{self} just ate #{found_food} units of food! (#{food_search_success})" if SHOW_FEEDING
      @food_search_success *= (rand(70..80)/100.0)
      @food_search_success -= rand(1..4)
      @food_search_success = @food_search_success.floor
      
    end
    
    def stress
      @nutrition -= rand(1..5)
      bad_temp = ((thermal_center - @environment.temperature).abs / thermal_variance).to_i
      if bad_temp > 0
        bad_temp = 3**(bad_temp - 1)
        puts "#{@name} bad temp! Lost #{bad_temp} health!" if SHOW_STRESS
        @nutrition -= bad_temp
      end
      if @nutrition <= 0
        say color("#{self} starved to death!", :red) if SHOW_STARVATION
        die
      end
    end
    
    def thermal_variance
      thermal_tolerance.diminish(2).to_i
    end
    
    def comfort_zone
      (thermal_center-thermal_variance..thermal_center+thermal_variance)
    end
    
    #TODO: Impliment actual injury tracking
    def injury
      @nutrition /= 2
    end
    
    def die
      say color("#{@name} died!", :red) if SHOW_DEATH
      @population.organisms.delete(self)
    end
    
    def choose_escape_plan
      tactics = [:running, :climbing, :swimming, :jumping]
      tactics.sort_by! {|tactic| -self[tactic]}
      tactics[Math.log(rand(15)+1,2).floor]
    end
    
    def reproduce_if_able
      if @nutrition > 50 + rand(40)
        reproduce
      end 
    end
    
    def reproduce
      (4 - Math.log(rand(15)+1,2).to_i).times do
        @nutrition -= (rand(10..20))
        child_genotype = @genotype.clone
        child_genotype.mutate
        if child_genotype.values.any? {|v| v <= 0 }
          puts "#{@name} gave birth, but the child didn't make it..." if SHOW_STILLBIRTH
        else
          child = Organism.new(@population,child_genotype)
          say color("#{@name} gave birth to a #{child.name}",:green) if SHOW_BIRTH
        end
      end
      if @nutrition <= 0
        say color("#{@name} didn't survive giving birth",:red) if SHOW_COMPLICATIONS # more likely for large 'litters'
        die
      end
    end
    
  end
end