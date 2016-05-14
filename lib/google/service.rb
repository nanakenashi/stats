require 'fileutils'
require 'googleauth'
require 'googleauth/stores/file_token_store'

module Google

  class Service

    OOB_URI             = 'urn:ietf:wg:oauth:2.0:oob'
    CLIENT_SECRETS_PATH = File.expand_path(File.dirname(__FILE__) + '/config/client_secret.json')
    CREDENTIALS_PATH    = File.join(Dir.home, '.credentials', "google-api.yaml")

    def initialize
      # should be implemented on sub class
    end

    private

    def authorize(scope)
      FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

      client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
      authorizer = Google::Auth::UserAuthorizer.new(
        client_id, scope, token_store)
      user_id = 'default'
      credentials = authorizer.get_credentials(user_id)
      if credentials.nil?
        url = authorizer.get_authorization_url(
          base_url: OOB_URI)
        puts "Open the following URL in the browser and enter the " +
             "resulting code after authorization"
        puts url
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI)
      end

      credentials
    end

  end

end
