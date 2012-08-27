require 'highline/import'
module LD24
  module Interface
    module_function
    def choose_card(cards)
      choose do |menu|
        menu.prompt = "Choose an adversity to inflict upon your organisms."
        menu.select_by = :index
        cards.each do |card|
          menu.choice(card.label,card.description) {card}
        end
      end
    end
  end
end


module Kernel
   def color(string, color)
     return HighLine.new.color(string, color)
   end
end