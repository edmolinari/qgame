require 'rails_helper'

RSpec.describe Player do
  subject { Player.new('player 1') }
  
  describe 'attributes' do
    it { expect(subject.name).to eq 'player 1' }
    it { expect(subject.sessions).to eq [] }
  end

  let(:game) { Game.new('test', '12') }
  let(:game2) { Game.new('test game 2', '19') }

  let(:player1) { Player.new 'player 1' }
  let(:player2) { Player.new 'player 2' }
  let(:player3) { Player.new 'player 3' }
  

  let(:session1) { Session.new(game, player1) }
  let(:session2) { Session.new(game, player2) }
  let(:session3) { Session.new(game, player3) }

  let(:session2_1) { Session.new(game2, player1) }
  let(:session2_2) { Session.new(game2, player2) }

  let(:death1) { Death.new(session1, session2, 'MOD_MACHINEGUN') }
  let(:death2) { Death.new(session1, session3, 'MOD_MACHINEGUN') }
  let(:deaths) { [death1, death2] }

  let(:death2_1) { Death.new(session2_1, session2_2, 'MOD_SHOTGUN') }
  let(:deaths2) { [death2_1] }

  before do
    game.deaths = deaths
    game2.deaths = deaths2

    player1.sessions = player1.sessions.push(session1)
    player1.sessions = player1.sessions.push(session2_1)

    player2.sessions = player2.sessions.push(session2)
    player2.sessions = player2.sessions.push(session2_2)


    session1.killings = [death1, death2]
    session2.murdereds = [death1]
    session3.murdereds = [death2]

    session2_1.killings = [death2_1]
    session2_2.murdereds = [death2_1]

  end
  
  describe '#general_total_kills' do
    it 'pulls total killings from all games sessions for player 1' do
      # 2 first session + 1 second session
      expect(player1.general_total_kills).to eq(3)
    end
  end


end