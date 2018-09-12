# frozen_string_literal: true

class LeagueTableUpdateJob < ApplicationJob
  queue_as :default

  def perform
    Competition::LeagueTable.active.each do |league_table|
      Season.update_teams(
        LeagueTableScrapper.seasons(league_table.url),
        league_table
      )
    end
  end
end
