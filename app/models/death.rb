class Death
  attr_accessor :killer, :victim, :cause_of_death

  def initialize(killer, victim, cause_of_death)
    @killer = killer
    @victim = victim
    @cause_of_death = cause_of_death
  end
  
end
