require 'google/apis/drive_v3'
require_relative 'service'

module Google

  class Drive < Service

    def initialize
      @service = Google::Apis::DriveV3::DriveService.new
      scope = Google::Apis::DriveV3::AUTH_DRIVE
      @service.authorization = authorize(scope)
    end

    def create_file(file_name, mime_type, upload_source)
      metadata = {
        name: file_name,
        mime_type: mime_type,
      }

      @service.create_file(metadata, upload_source: upload_source)
    end

    def list_files()
      response = @service.list_files(fields: 'nextPageToken, files(id, name)')

      response.files.each_with_object([]) do |file, result|
        result << { :id => file.id, :name => file.name }
      end
    end

    def delete_file(file_id)
      @service.delete_file(file_id)
    end

  end

end
