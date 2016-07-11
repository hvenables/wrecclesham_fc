require 'rails_helper'

RSpec.describe Team, type: :model do
  let!(:league) { create(:league_table, active_first_team_table: true) }
  let!(:ufc_farnham) { create :team,
                      team: "UFC Farnham",
                      games: 10,
                      won: 5,
                      drawn: 3,
                      lost: 2,
                      goals_for: 20,
                      goals_against: 10,
                      goal_difference: 10,
                      points: 18,
                      league_table: league
  }
  let!(:deepcut) { create :team,
                      team: "Deepcut",
                      games: 10,
                      won: 4,
                      drawn: 4,
                      lost: 2,
                      goals_for: 20,
                      goals_against: 10,
                      goal_difference: 10,
                      points: 16,
                      league_table: league
  }
  let!(:woking_tigers) { create :team,
                      team: "Woking Tigers",
                      games: 10,
                      won: 4,
                      drawn: 4,
                      lost: 2,
                      goals_for: 21,
                      goals_against: 10,
                      goal_difference: 11,
                      points: 16,
                      league_table: league
  }
  context '#ordered_on_points' do
    scenario 'Should order teams by points and goal difference' do
      expect(Team.ordered_on_points[0]).to eq ufc_farnham
      expect(Team.ordered_on_points[1]).to eq woking_tigers
      expect(Team.ordered_on_points[2]).to eq deepcut
    end
  end
  context '#position' do
    scenario 'Should return the position in the table based on points and goal differnce' do
      expect(ufc_farnham.position).to eq 1
      expect(woking_tigers.position).to eq 2
      expect(deepcut.position).to eq 3
    end
  end
end
