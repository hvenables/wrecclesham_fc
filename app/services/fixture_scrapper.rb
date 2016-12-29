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
    fixture_list = extract_fixtures(doc)

    fixture_list.each{|elem| elem.gsub!(/\s\s+/,"")}.reject!(&:blank?)

    split_fixtures(fixture_list)
  end

  def self.extract_fixtures(doc)
    fixture_list = []

    doc.css('table.Table').css('td').each do |element|
      fixture_list << element.text
    end

    fixture_list
  end

  def self.split_fixtures(fixtures)
    fixture_list = []

    fixtures.each do |fixture|
      if fixture.match(/^[A-Z][a-zA-Z0-9]{2}[A-Z0-9]$/)
        fixture_list << @current_fixture if @current_fixture
        @current_fixture = []
        @current_fixture << fixture
      else
        @current_fixture << fixture
      end
    end

    binding.pry

    fixture_list
  end
end
