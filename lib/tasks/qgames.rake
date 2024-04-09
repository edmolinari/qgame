namespace :qgames do
  desc "generate matches report"
  task matches_report: :environment do
    parse = ParseQgame.new
    parse.generate_matches
    puts JSON.pretty_generate(JSON.parse(parse.create_matches_json_report))
  end

  task matches_ranking: :environment do
    desc "generate matches ranking"
    parse = ParseQgame.new
    parse.generate_matches
    puts JSON.pretty_generate(JSON.parse(parse.player_ranking))
  end

  desc "generate matches report grouped by deaths"
  task deaths_report: :environment do
    parse = ParseQgame.new
    parse.generate_matches
    puts JSON.pretty_generate(JSON.parse(parse.deaths_report))
  end
  
end
