require 'rails_helper'

RSpec.describe Team, type: :model do
  context '#ordered_on_points' do
    let!(:ufc_farnham) { create :team,
                        team: "UFC Farnham",
                        games: 10,
                        won: 5,
                        drawn: 3,
                        lost: 2,
                        goals_for: 20,
                        goals_against: 10,
                        goal_difference: 10,
                        points: 18 }
    let!(:deepcut) { create :team,
                        team: "Deepcut",
                        games: 10,
                        won: 4,
                        drawn: 4,
                        lost: 2,
                        goals_for: 20,
                        goals_against: 10,
                        goal_difference: 10,
                        points: 16 }
    let!(:woking_tigers) { create :team,
                        team: "Woking Tigers",
                        games: 10,
                        won: 4,
                        drawn: 4,
                        lost: 2,
                        goals_for: 21,
                        goals_against: 10,
                        goal_difference: 11,
                        points: 16 }
    scenario 'Should order teams by points and goal difference' do
      expect(Team.ordered_on_points[0]).to eq ufc_farnham
      expect(Team.ordered_on_points[1]).to eq woking_tigers
      expect(Team.ordered_on_points[2]).to eq deepcut
    end
  end
end
