require 'open-uri'
require 'nokogiri'

class FixtureScrapper

  COMPETITIONS = ['Div2', 'Div4', 'SLJC', 'JunC', 'IntC', 'PreC']

  def self.get_fixtures_data(url)
    doc = scrap_website(url)
    fixtures(doc)
  end

  def self.get_results_data(url)
    doc = scrap_website(url)
    results(doc)
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

    fixture_list.each{|elem| elem.gsub!(/\s?/,"")}.reject!(&:blank?)

    split_fixtures(fixture_list)
  end

  def self.results(doc)
    fixture_list = extract_results(doc)

    fixture_list.each{|elem| elem.gsub!(/\s?/,"")}.reject!(&:blank?)

    split_fixtures(fixture_list)
  end

  def self.extract_fixtures(doc)
    fixture_list = []

    doc.css('table.League-Fixtures_Table.Table').css('td').each do |element|
      fixture_list << element.text
    end

    fixture_list
  end

  def self.extract_results(doc)
    fixture_list = []

    doc.css('table.Table').css('td').each do |element|
      fixture_list << element.text
    end

    fixture_list
  end

  def self.split_fixtures(fixtures)
    fixture_list = []

    fixtures.each do |fixture|
      if ([fixture] & COMPETITIONS).present?
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
