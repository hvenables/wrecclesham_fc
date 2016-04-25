require 'open-uri'
require 'nokogiri'

class Team < ApplicationRecord
  # has_many :players
  belongs_to :league_table

  def self.get_table_data(url)
    doc = Nokogiri::HTML(open(url)) do |config|
        config.noblanks
    end
    table(doc)
  end

  def self.ordered_on_points
    order(points: :desc, goal_difference: :desc)
  end

  private

  def self.table(doc)
    @table = []
    doc.css('table.leagueTable').css('td').each do |element|
      @table << element.text
    end
    @table = @table.reject!(&:empty?).drop(10)
    split_teams(@table)
  end

  def self.split_teams(teams)
    table = []
    10.times do
      table << teams.pop(9)
    end
    table
  end
end
