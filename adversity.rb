module LD24
  class Adversity
    attr_reader :name, :description, :level
    def label
      "#{name} (Level #{level})"
    end
    
    def self.draw_cards
      types = Adversity.constants.sample(3)
      cards = types.map do |t|
        level = [1,1,1,1,2,2,2,3,3,4].sample
        Adversity.const_get(t).new(level)
      end
      cards
    end
  end
end