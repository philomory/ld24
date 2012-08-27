# Diminishing returns forumula borrowed from http://lostsouls.org/grimoire_diminishing_returns
class Numeric
  def diminish(scale)
    input, scale = self.to_f, scale.to_f
    factor = input / scale
    position = (Math.sqrt(8 * factor + 1) - 1) / 2
    position * scale
  end
end  