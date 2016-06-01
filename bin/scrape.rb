require 'yaml'
require_relative '../lib/web/scraper'

scraper = Web::Scraper.new
sites = YAML.load_file('config/url.yml')[0]

results = sites.each_with_object({}) do |site, result|
  page = scraper.fetch_page(site['url'])
  result[site['label']] = page.css(site['selector']).text
end

p results
