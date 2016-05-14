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
  end

end
