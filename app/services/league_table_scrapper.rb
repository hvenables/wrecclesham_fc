# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class LeagueTableScrapper
  def self.get_team_data(url)
    doc = Nokogiri::HTML(open(url), &:noblanks)
    table(doc)
  end

  private

  def self.table(doc)
    @table = []
    doc.css('table.League-TableDetail_Table.Table').css('td').each do |element|
      @table << element.text
    end

    @table.each { |elem| elem.gsub!(/\s\s+/, '') }.pop(1)

    split_teams(@table)
  end

  def self.split_teams(teams)
    table = []
    table << teams.pop(20) while teams.present?
    table
  end
end
