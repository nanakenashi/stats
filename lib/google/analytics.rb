require 'google/apis/analytics_v3'
require_relative 'service'

module Google

  class Analytics < Service

    def initialize
      @service = Google::Apis::AnalyticsV3::AnalyticsService.new
      scope = Google::Apis::AnalyticsV3::AUTH_ANALYTICS_READONLY
      @service.authorization = authorize(scope)
    end

    def get_ga_data(id, metrics, filters=nil, start_date=nil, end_date=nil)
      start_date = get_n_day_ago(1) if start_date.nil?
      end_date   = get_n_day_ago(1) if end_date.nil?

      result = @service.get_ga_data(id, start_date, end_date, metrics, filters: filters).to_json

      format(JSON.parse(result))
    end

    private

    def get_n_day_ago(n)
      (Date.today - n).strftime('%Y-%m-%d')
    end

    def format(raw_date)
      rows = raw_date['totalsForAllResults']

      rows.each_with_object({}) do |(key, value), result|
        result[key] = value
      end
    end

  end

end
