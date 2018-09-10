# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class LeagueTableScrapper
  def self.seasons(url)
    new(url).seasons
  end

  private_class_method :new
  def initialize(url)
    @url = url
  end

  def seasons
    @url
      .yield_self(&method(:scrap_website))
      .yield_self(&method(:scrap_table_rows))
      .yield_self(&method(:extract_seasons))
  end

  private

  def scrap_website(url)
    Nokogiri::HTML(open(url), &:noblanks)
  end

  def scrap_table_rows(seasons)
    seasons.css('table.League-TableDetail_Table.Table').css('tr')
  end

  def extract_seasons(seasons)
    seasons.each_with_object({}).with_index do |(element, table), index|
      next if index < 2 || index == seasons.length - 1
      team_data = element.text
                         .gsub(/\s\s+/, ' ')
                         .squish
                         .split(/(?<=[\w])\s(?=[\d])|(?<=[\d])\s/)

      team_name = team_data.delete_at(1)

      table[team_name] = team_data
    end
  end
end
