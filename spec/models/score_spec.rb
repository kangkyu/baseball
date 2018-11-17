require 'rails_helper'

RSpec.describe Score, type: :model do
  let(:score) { Score.create attributes }

  let(:game) { Game.create! field: 'Fenway Park', away_team: away_team, home_team: home_team }
  let(:away_team) { Team.create! name: 'Yankees' }
  let(:home_team) { Team.create! name: 'Red Sox' }
  let(:away_team_player_1) { Player.create(name: 'Aaron Judge', team: away_team) }
  let(:away_team_player_2) { Player.create(name: 'Giancarlo Stanton', team: away_team) }

  context 'with game and player' do
    let(:attributes) { {game_id: game.id, player_id: away_team_player_1.id, point: 3} }
    it 'is valid' do
      expect(score).to be_valid
    end
  end

  context 'without game' do
    let(:attributes) { {game_id: '', player_id: away_team_player_1.id, point: 3} }
    it 'is not valid' do
      expect(score).not_to be_valid
    end
  end

  context 'without player' do
    let(:attributes) { {game_id: game.id, player_id: '', point: 3} }
    it 'is not valid' do
      expect(score).not_to be_valid
    end
  end

  context 'without point' do
    let(:attributes) { {game_id: game.id, player_id: away_team_player_1.id} }
    it 'is not valid' do
      expect(score).not_to be_valid
    end
  end
end
