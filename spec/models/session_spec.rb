require 'rails_helper'

RSpec.describe Session do
  let(:game) { Game.new('test', '12') }
  
  let(:player1) { Player.new 'player 1' }
  let(:player2) { Player.new 'player 2' }
  let(:player3) { Player.new 'player 3' }
  

  let(:session1) { Session.new(game, player1) }
  let(:session2) { Session.new(game, player2) }
  let(:session3) { Session.new(game, player3) }

  let(:death1) { Death.new(session1, session2, 'MOD_MACHINEGUN') }
  let(:death2) { Death.new(session1, session3, 'MOD_MACHINEGUN') }
  let(:deaths) { [death1, death2] }

  
  before do
    game.deaths = deaths
    
    session1.killings = [death1, death2]
    session2.murdereds = [death1]
    session3.murdereds = [death2]
  end

  subject { session1 }
  
  describe 'attributes' do
    it { expect(subject.game).to eq game }
    it { expect(subject.player).to eq player1 }
    it { expect(subject.killings).to eq deaths }
    it { expect(subject.murdereds).to eq [] }
  end
  
  describe '#kills' do
    it 'pulls total killings from the session' do
      expect(session1.kills).to eq(2)
    end

    context 'When <world> kill a player, that player loses -1 kill score' do
      let(:death3) { Death.new('<world>', session1, 'MOD_TRIGGER_HURT') }
      before { session1.murdereds = [death3] }
      
      it 'pulls total killings from the session -1 since world killed the player' do
        expect(session1.kills).to eq(1)
      end

    end
  end

  describe '#murdered_by_world_count' do
    let(:death3) { Death.new('<world>', session1, 'MOD_TRIGGER_HURT') }
    let(:death4) { Death.new('<world>', session1, 'MOD_TRIGGER_HURT') }
    let(:death5) { Death.new(session2, session1, 'MOD_TRIGGER_HURT') }
    before { session1.murdereds = [death3, death4, death5] }
    
    it 'pulls total killings from the session -1 since world killed the player' do
      expect(session1.murdered_by_world_count).to eq(2)
    end

    
  end


end