class Session
  attr_accessor :game, :player, :killings, :murdereds

  def initialize(game, player)
    @game = game
    @player = player
    @killings = []
    @murdereds = []

    @game.sessions.push(self)
    #@player.sessions.push(self) unless @player.sessions.include?(self)
  end

  def kills
    @killings.size - murdered_by_world_count
  end

  def murdered_by_world_count
    @murdereds.filter { |death| death.killer == '<world>' }.size
  end
end