class Game
  attr_accessor :name, :init, :shutdown, :sessions, :deaths

  def initialize(name = '', init = '', shutdown = '', sessions = [])
    @name = name
    @init = init
    @shutdown = shutdown
    @sessions = sessions
    @deaths = []
  end

  # the number of total killings -  includes player and world deaths.
  def total_kills
    @deaths.size
  end

  # array containing players names - there's no <world> player
  def players
    @sessions.map { |game| game.player.name }
  end

  def kills
    res = {}
    @sessions.map { |session| res[session.player.name] = session.kills}
    res
  end

end