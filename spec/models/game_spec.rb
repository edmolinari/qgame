require 'rails_helper'

RSpec.describe Game do
  subject { Game.new('game1', '12:00', '19:00') }
  
  describe 'attributes' do
    it { expect(subject.name).to eq 'game1' }
    it { expect(subject.init).to eq '12:00' }
    it { expect(subject.shutdown).to eq '19:00' }
    it { expect(subject.sessions).to eq [] }
    it { expect(subject.deaths).to eq [] }
  end

  let(:game) { Game.new('test', '12') }

  let(:player1) { Player.new 'player 1' }
  let(:player2) { Player.new 'player 2' }
  let(:player3) { Player.new 'player 3' }
  let(:player4) { Player.new 'player 4' }

  let(:session1) { Session.new(game, player1) }
  let(:session2) { Session.new(game, player2) }
  let(:session3) { Session.new(game, player3) }
  let(:session4) { Session.new(game, player4) }

  let(:death1) { Death.new(session1, session2, 'MOD_MACHINEGUN') }
  let(:death2) { Death.new(session1, session3, 'MOD_MACHINEGUN') }
  let(:death3) { Death.new(session2, session4, 'MOD_SHOTGUN') }
  let(:deaths) { [death1, death2, death3] }

  before do
    game.deaths = deaths

    session1.killings = [death1, death2]
    session2.killings = [death3]
    session3.murdereds = [death2]
    session4.murdereds = [death3]

  end
  
  describe '#players' do
    it 'pulls array containing players names' do
      expect(game.players).to eq(["player 1", "player 2", "player 3", "player 4"])
    end
  end

  describe '#total_kills' do
    it 'pulls the number of total killings' do
      expect(game.total_kills).to eq(3)
    end
  end

  describe '#kills' do
    it 'pulls a hash containing killings per player' do
      expected_result = {"player 1"=>2, "player 2"=>1, "player 3"=>0, "player 4"=>0}
      expect(game.kills).to eq(expected_result)
    end
  end

end