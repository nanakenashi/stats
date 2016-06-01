require 'google/apis/webmasters_v3'
require_relative 'service'

module Google

  class Webmasters < Service

    def initialize
      @service = Google::Apis::WebmastersV3::WebmastersService.new
      scope = Google::Apis::WebmastersV3::AUTH_WEBMASTERS_READONLY
      @service.authorization = authorize(scope)
    end

    def list_sitemaps(site_url)
      JSON.parse(@service.list_sitemaps(site_url).to_json)
    end

    def query_search_analytics(site_url, start_date=nil, end_date=nil)
      request = get_request(start_date, end_date)
      raw_data = JSON.parse(@service.query_search_analytics(site_url, request).to_json)

      format(raw_data)
    end

    private

    def get_request(start_date, end_date)
      request = Google::Apis::WebmastersV3::SearchAnalyticsQueryRequest.new
      request.start_date = start_date || get_last_week
      request.end_date   = end_date || get_last_week

      request
    end

    def get_last_week
      (Date.today - 7).strftime('%Y-%m-%d')
    end

    def format(raw_date)
      rows = raw_date['rows'][0]

      rows.each_with_object({}) do |(key, value), result|
        result[key] = value.to_i             if key === 'clicks'
        result[key] = (value * 100).round(2) if key === 'ctr'
        result[key] = value.to_i             if key === 'impressions'
        result[key] = value.round(1)         if key === 'position'
      end
    end

  end

end
