require 'open-uri'
require 'nokogiri'

class Team < ApplicationRecord
  # has_many :players
  belongs_to :league_table

  def self.get_team_data(url, number_of_teams)
    doc = Nokogiri::HTML(open(url)) do |config|
        config.noblanks
    end
    table(doc, number_of_teams)
  end

  def self.ordered_on_points
    order(points: :desc, goal_difference: :desc)
  end

  private

  def self.table(doc, number_of_teams)
    @table = []
    doc.css('table.leagueTable').css('td').each do |element|
      @table << element.text
    end
    @table = @table.reject!(&:empty?).drop(10)
    split_teams(@table, number_of_teams)
  end

  def self.split_teams(teams, number_of_teams)
    table = []
    number_of_teams.times do
      table << teams.pop(9)
    end
    table
  end
end
