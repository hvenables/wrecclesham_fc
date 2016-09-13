require 'open-uri'
require 'nokogiri'

class FixtureScrapper

  MONTHS = ['9', '10', '11', '12', '1', '2', '3', '4']

  def self.get_fixtures(url)
    @fixture_list = []
    @dates = []
    all_url(url).each do |fixture|
      doc = Nokogiri::HTML(open(fixture)) do |config|
          config.noblanks
      end
      @fixture_list << sorted_fixtures(doc)
      @dates << sorted_dates(doc)
    end

    return @fixture_list, @dates
  end

  private

  class << self
    def all_url(url)
      urls = []
      MONTHS.each do |month|
        urls << (url.chop + month)
      end
      urls
    end

    def raw_text(doc)
      scores = []
      doc.css('table.white').css('span').each do |score|
        scores << score.text
      end
      format_text(scores)
    end

    def format_text(doc)
      doc.each do |substring|
        substring.strip!
      end
    end

    def order_by_month(doc)
      array_scores = []
      counter = -1
      doc.each do |substring|
        if substring.match(/September|October|November|December|January|February|March|April/)
          counter += 1
          array_scores << []
        end
        array_scores[counter] << substring if counter >= 0
      end
      array_scores
    end

    def sort_data(doc)
      order_by_month(
        raw_text(doc)
      )
    end

    def sorted_dates(doc)
      data = sort_data(doc)
      dates = []

      data.each do |week|
        dates << week.shift(1)
      end
      dates
    end

    def sorted_fixtures(doc)
      array_scores = sort_data(doc)

      formatted_score = []

      second_counter = -1
      third_counter = 0
      array_scores.each do |week|
        formatted_score << []
        second_counter += 1
        week.each_with_index do |score|
          if third_counter > 0
            @temp_score << score
            third_counter -= 1
          elsif /^[0-9]{1,45}$/.match(score) || /^[-]{1}$/.match(score) || /^[H]{1}$/.match(score)
            formatted_score[second_counter] << @temp_score if defined? @temp_score
            third_counter += 4
            @temp_score = []
            @temp_score << score
          end
        end
      end
      formatted_score
    end
  end
end
