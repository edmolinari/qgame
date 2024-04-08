require 'rails_helper'

RSpec.describe Death do
  let(:game) { Game.new('test', '12') }
  let(:player1) { Player.new 'player 1' }
  let(:player2) { Player.new 'player 2' }
  let(:session1) { Session.new(game, player1) }
  let(:session2) { Session.new(game, player2) }
  
  subject { Death.new(session1, session2, 'MOD_MACHINEGUN') }

  describe 'attributes' do
    it { expect(subject.killer).to eq session1 }
    it { expect(subject.victim).to eq session2 }
    it { expect(subject.cause_of_death).to eq 'MOD_MACHINEGUN' }
  end

end