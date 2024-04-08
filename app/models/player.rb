class Player
  attr_accessor :name, :sessions

  def initialize(name = '', sessions = [])
    @name = name
    @sessions = sessions
  end

  def general_total_kills
    @sessions.map(&:kills).reduce { |accumulator, kills| accumulator + kills } if @sessions.size > 0
  end

end