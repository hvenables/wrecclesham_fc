class MigrateCompetitionData < ActiveRecord::Migration[5.0]
  def change
    migrate_data
  end

  def migrate_data
    LeagueTable.all.each do |league_table|
      Competition.create!(
        type: 'Competition::LeagueTable',
        year: league_table.year,
        name: league_table.name,
        abbreviation: league_table.abbreviation,
        url: league_table.url,
        fixture_url: league_table.fixture_url,
        result_url: league_table.results_url,
        active: league_table.active
      )
    end

    Cup.all.each do |cup|
      Competition.create!(
        type: 'Competition::Cup',
        year: cup.year,
        name: cup.name,
        abbreviation: cup.abbreviation,
        fixture_url: cup.fixture_url,
        result_url: cup.results_url,
        active: cup.active
      )
    end
  end
end
