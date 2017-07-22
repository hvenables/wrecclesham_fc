class MigrateRelatedCompetitionData < ActiveRecord::Migration[5.0]
  def change
    Fixture.all.update_all(competition_type: 'Competition')
    TeamCompetition.all.update_all(competition_type: 'Competition')
  end
end
