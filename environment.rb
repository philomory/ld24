module LD24
  class Environment
    attr_accessor :temperature, :water, :soil, :ruggedness, :verdancy, :predator, :food
    def initialize
      @temperature = 47 + rand(7)
      @food = 300
      @predator = Predator.new
      @predator.members.each {|m| @predator[m] = 14 + rand(7)}
      @predator.population = 3
    end
    def replenish
      self.food += rand(50..150) # Need more logic here
    end  
  end
end