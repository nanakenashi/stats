require_relative '../lib/google/webmasters'

webmasters = Google::Webmasters.new

site_url = ''
result = webmasters.query_search_analytics(site_url)

p result
