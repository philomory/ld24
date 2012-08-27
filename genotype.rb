module LD24
  Genotype =  Struct.new(
    # Mobility
    :running, :climbing, :swimming, :jumping, :flying,
    # Perception
    :smell, :visual_acuity, :visual_range, :night_vision, :hearing,
    # Endurance
    :stamina, :immune_system, :recovery, :thermal_tolerance, :thermal_center,
    # Food
    :food_placeholder,
    # Physical
    :size, :claws, :kick, :horns, :teeth, :venom,
    # Cognitive
    :memory, :problem_solving, :danger_assesment,
    # Behavior
    :behavior_placeholder
  ) do
    def mutate
      self.members.each do |m|
        case rand(32)
        when (0..1)
          # large mutation
          self[m] += rand(-20..20)
        when (2..4)
          # medium mutation
          self[m] += rand(-10..10)
        when (5..8)
          # small mutation
          self[m] += rand(-5..5)
        else
          # No mutation for this stat
        end
      end
    end
  end
end