class PagesController < ApplicationController
  def home
  end

  def matches_report
    parse = ParseQgame.new
    parse.generate_matches
    @data = JSON.pretty_generate(JSON.parse(parse.create_matches_json_report))
  end
  
  def ranking_report
    parse = ParseQgame.new
    parse.generate_matches
    @data = JSON.pretty_generate(JSON.parse(parse.player_ranking))
  end

  def deaths_report
    parse = ParseQgame.new
    parse.generate_matches
    @data = JSON.pretty_generate(JSON.parse(parse.create_matches_json_report))
  end

  def raw_file
    @data = ''
    File.foreach(Rails.root.join('app', 'assets', 'config/qgames.log')) do |line| 
      @data << line
    end
  end
end