require 'open-uri'
require 'nokogiri'

class FixtureScrapper

  def self.get_fixtures_data(url)
    doc = scrap_website(url)
    fixtures(doc)
  end

  private

  def self.scrap_website(url)
    doc = Nokogiri::HTML(open(url)) do |config|
      config.noblanks
    end

    doc
  end

  def self.fixtures(doc)
    fixture_list = []
    doc.css('table.League-Fixtures_Table.Table').css('td').each do |element|
      fixture_list << element.text
    end

    fixture_list.each{|elem| elem.gsub!(/\s?/,"")}.reject!(&:blank?)

    split_fixtures(fixture_list)
  end

  def self.split_fixtures(fixtures)
    fixture_list = []
    while fixtures.any? do
      fixture_list << fixtures.pop(6)
    end
    fixture_list
  end

end
