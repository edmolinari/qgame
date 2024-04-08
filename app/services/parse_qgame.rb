class ParseQgame
  attr_accessor :matches, :players

  FILE_LOCAL = 'config/qgames.log'

  def initialize
    @matches = []
    @players = []
  end

  def generate_matches
    File.foreach(Rails.root.join('app', 'assets', FILE_LOCAL)) do |line| 
      data = line.split(" ")
      action = data[1]
      
      case action
      when 'InitGame:'
        create_game(data)
      when 'ClientUserinfoChanged:'
        create_player(data, line)
      when 'Kill:'
        create_kill(line)
      end
    end
  end

  def create_matches_json_report
    matches_report = {}
    @matches.map do |match|
      matches_report.merge!({
        match.name => {
          "total_kills"=> match.total_kills,
          "players"=> match.players,
          "kills"=> match.kills
        }  
      })
    end
    matches_report.to_json
  end

  def create_or_find_player(name)
    existing_player = @players.filter { |player| player.name == name }&.first
    if existing_player.nil?
      new_player = Player.new(name)
      @players.push(new_player)
      return new_player
    else
      return existing_player
    end
  end

  private

  def create_game(data)
    #puts ' ----'
    @matches.push(Game.new("game #{@matches.size + 1}"))
    #puts 'create '+ matches.last.name
  end

  def create_player(data, line)
    # Create or locate player
    name = get_name_from_line(line)
    #puts "create_or_find_player #{name}"
    player = create_or_find_player(name)

    current_match = @matches.last
    # Create only 1 session per user per match
    if current_match.sessions.filter { |session| session.player.name == name }.size == 0
      session = Session.new(current_match, player)
    end
  end

  def create_kill(data)
    killer_name = get_killer_from_line(data)
    murdered_name = get_murdered_from_line(data)
    cause_of_death = get_cause_from_line(data)
    #puts "create kill #{killer_name} - #{murdered_name} - #{cause_of_death}"

    killer = killer_name == '<world>' ? '<world>' : locate_session(killer_name)
    murdered = locate_session(murdered_name)
    
    death = Death.new(killer, murdered, cause_of_death)
    @matches.last.deaths.push(death)
    killer.killings.push(death) unless killer == '<world>'
    murdered.murdereds.push(death)
  end

  def locate_session(name)
    @matches.last.sessions.filter { |session| session.player.name == name }&.first
  end

  def get_name_from_line(line)
    init = 'n\\'
    finish = '\\t'
    line[/#{Regexp.escape(init)}(.*?)#{Regexp.escape(finish)}/m,1]
  end

  def get_killer_from_line(line)
    init = ': '
    finish = ' killed'
    line[/#{Regexp.escape(init)}(.*?)#{Regexp.escape(finish)}/m,1].split(':').last.strip
  end

  def get_murdered_from_line(line)
    init = 'killed'
    finish = ' by'
    line[/#{Regexp.escape(init)}(.*?)#{Regexp.escape(finish)}/m,1].strip
  end

  def get_cause_from_line(line)
    line.split(' ').last
  end

end