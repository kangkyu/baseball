require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { Team.create attributes }

  context 'with name' do
    let(:attributes) { {name: 'Dodgers'} }
    it 'is valid' do
      expect(team).to be_valid
    end
  end

  context 'without name' do
    let(:attributes) { {} }
    it 'is not valid' do
      expect(team).not_to be_valid
    end
  end
end
