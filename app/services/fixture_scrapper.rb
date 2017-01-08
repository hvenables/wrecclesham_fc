require 'open-uri'
require 'nokogiri'

class FixtureScrapper

  attr_reader :url, :data

  def initialize(url)
    @url = url
    @data = scrap_website
  end

  def fixtures
    fixture_list = extract_fixtures(data)

    fixture_list.each{|elem| elem.gsub!(/\s\s+/,"")}.reject!(&:blank?)

    split_fixtures(fixture_list)
  end

  private

  def scrap_website
    doc = Nokogiri::HTML(open(url)) do |config|
      config.noblanks
    end

    doc
  end

  def extract_fixtures(web_data)
    fixture_list = []

    web_data.css('table.Table').css('td').each do |element|
      fixture_list << element.text
    end

    fixture_list
  end

  def split_fixtures(fixtures)
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

    fixture_list << @current_fixture if @current_fixture

    fixture_list
  end
end
