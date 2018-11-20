require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player) { Player.create attributes }
  let(:team) { Team.create name: 'Los Angeles Dodgers' }

  context 'with name and a team' do
    let(:attributes) { { name: 'Clayton Kershaw', team: team } }
    it 'is valid' do
      expect(player).to be_valid
    end
  end

  context 'without a team' do
    let(:attributes) { { name: 'Matt Kemp' } }
    it 'is not valid' do
      expect(player).not_to be_valid
    end
  end

  context 'without name' do
    let(:attributes) { { name: '', team: team } }
    it 'is not valid' do
      expect(player).not_to be_valid
    end
  end
end
