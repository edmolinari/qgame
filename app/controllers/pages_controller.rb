class PagesController < ApplicationController
  def home
  end

  def matches_report
    parse = ParseQgame.new
    parse.generate_matches
    @data = 'asdadsad'
    #@data = parse.generate_create_matches_json_report
  end

  def raw_file
  end
end