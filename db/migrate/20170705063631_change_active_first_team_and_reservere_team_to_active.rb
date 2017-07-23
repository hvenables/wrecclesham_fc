class ChangeActiveFirstTeamAndReservereTeamToActive < ActiveRecord::Migration[5.0]
  def change
    remove_column :league_tables, :active_first_team_table
    remove_column :league_tables, :active_reserve_team_table

    add_column :league_tables, :active, :boolean, default: false
  end
end
