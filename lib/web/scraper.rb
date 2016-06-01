require 'open-uri'
require 'nokogiri'

module Web
  class Scraper

    def initialize
    end

    def fetch_page(url)
      charset = nil
      html = open(url) do |f|
        charset = f.charset
        f.read
      end

      Nokogiri::HTML.parse(html, nil, charset)
    end

  end
end
