module LD24
  Predator = Struct.new(
    :population,
    
    :size, :strength, :venom,
    
    :running, :climbing, :swimming, :jumping,
    
    :perception
  
  ) do
    def hunt(prey)
      caught_prey = chase(prey)
      if caught_prey
        fight(prey)
      else
        puts "#{prey} fled from a predator!" if SHOW_FLED
      end
    end
    
    def chase(prey)
      tactic = prey.choose_escape_plan
      raise unless tactic
      self[tactic] * (rand(50)+75) > prey[tactic] * (rand(100)+75)
    end
    
    def fight(prey)
      attack = strength * (rand(50) + 75)
      defence = prey.stamina * (rand(50) + 75)
      case attack
      when (0...defence/2)
        puts "#{prey} was caught by a predator, but escaped unharmed!" if SHOW_ESCAPED
      when (defence/2...defence)
        puts "#{prey} was injured by a predator, but escaped!" if SHOW_INJURED
        prey.injury
      else
        say color("#{prey} was killed by a predator!",:red) if SHOW_EATEN
        prey.die
      end
    end
    
  end
end