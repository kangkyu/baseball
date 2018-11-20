require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { Game.create attributes }

  let(:away_team) { Team.create! name: 'Yankees' }
  let(:home_team) { Team.create! name: 'Red Sox' }

  context 'with teams and a field' do
    let(:attributes) { {field: 'Fenway Park', away_team: away_team, home_team: home_team} }
    it 'is valid' do
      expect(game).to be_valid
    end
  end

  context 'without field' do
    let(:attributes) { {field: '', away_team: away_team, home_team: home_team} }
    it 'is not valid' do
      expect(game).not_to be_valid
    end
  end

  context 'without teams' do
    let(:attributes) { {field: 'Fenway Park'} }
    it 'is not valid' do
      expect(game).not_to be_valid
    end
  end
end
