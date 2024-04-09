namespace :qgames do
  desc "generate matches report"
  task matches_report: :environment do
    parse = ParseQgame.new
    parse.generate_matches
    puts JSON.pretty_generate(JSON.parse(parse.create_matches_json_report))
  end

  desc "generate matches ranking"
  task matches_ranking: :environment do
    parse = ParseQgame.new
    parse.generate_matches
    puts JSON.pretty_generate(JSON.parse(parse.player_ranking))
  end

  
end
