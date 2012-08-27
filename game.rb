module LD24
  class Game
    attr_reader :environment, :population
    
    def initialize
      $game = self
      @environment = Environment.new
      @population = Population.new(@environment)
      @level = 0
    end
    
    def play
      say "Welcome to ADVERSITY"
      say "You begin with 20 organisms."
      say "Over time, they eat, reproduce, flee predators, and deal with environmental hazards"
      say "Every so often, they have to face Adversity."
      say "That's where you come in..."
      puts
      say "Press enter to continue."
      gets
      loop do
        take_turn
      end
    end
    
    def tick
      environmental_replenishment
      feeding
      environmental_stresses
      predation
      reproduction
      show_status if SHOW_STATUS
      pause if PAUSE_AFTER_TICK
    end
    
    def pause
      puts "Press enter to continue"
      gets
    end
    
    def take_turn
      puts
      if @level == 0
        ticks = 20
        puts "Your organisms will have 200 ticks to mingle before they encounter their first adversity."
      else
        ticks =  [25,50,100,250][@level-1]
        puts "Enduring a level #{@level} adversity has bought your organisms #{ticks} ticks of relative quiet before the next disaster."
      end
      show_status
      puts "Press enter to run #{ticks} ticks."
      gets
      ticks.times do |i|
        puts  
        tick
      end
      adversity
    end
    
    def environmental_replenishment
      say color("Phase 1: Environmental Replenishment", :blue)
      @environment.replenish
    end
    
    def feeding
      say color("Phase 2: Feeding", :blue)
      @population.feed
    end
    
    def environmental_stresses
      say color("Phase 3: Environmental Stress", :blue)
      @population.stress
    end
    
    def predation
      say color("Phase 4: Predation", :blue)
      @population.predation
    end
    
    def reproduction
      say color("Phase 5: Reproduction", :blue)
      @population.reproduce
    end
    
    def adversity
      cards = Adversity.draw_cards
      card = Interface.choose_card(cards)
      card.apply(@population)
      @level = card.level
    end
    
    def show_status
      puts 
      puts "Population: #{@population.organisms.count}\tFood:#{@environment.food}"
      puts
    end
    
  end
end