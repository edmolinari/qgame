require 'rails_helper'

RSpec.describe ParseQgame do
  subject { ParseQgame.new }

  describe 'attributes' do
    it { expect(subject.matches).to eq [] }
    it { expect(subject.players).to eq [] }
  end

  describe "#generate_matches" do
    before { subject.generate_matches }
    it { expect(subject.matches.size).to eq(21) } 
  end

  describe "#create_matches_report" do
    before { subject.generate_matches }
    let(:expected_game1_result) { {
      "kills"=>{"Isgalamido"=>0}, 
      "players"=>["Isgalamido"], 
      "total_kills"=>0} 
    }
    it { expect(JSON.parse(subject.create_matches_json_report)['game 1']).to eq(expected_game1_result) }
    #it {  pp JSON.parse(subject.create_matches_json_report) }
  end

  describe "#create_or_find_player" do
    it { expect(subject.players).to eq([]) }
    it 'creates a new player' do
      player = subject.create_or_find_player('new') 
      expect(subject.players).to eq([player])
    end

    context 'player already exists' do
      let(:player) { Player.new('existing') }
      before { subject.players.push(player)}

      it { expect(subject.players).to eq([player]) }
      it 'returns an existing player' do
        existing_player = subject.create_or_find_player('existing') 
        expect(subject.players).to eq([existing_player])
      end
    end

  end
  

end