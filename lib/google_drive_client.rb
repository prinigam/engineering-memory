require "google/apis/drive_v3"
require "googleauth"
require "googleauth/stores/file_token_store"

class GoogleDriveClient
  attr_reader :drive

  APPLICATION_NAME = "Engineering Memory"
  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_FILE

  def initialize
    @drive = Google::Apis::DriveV3::DriveService.new
    @drive.client_options.application_name = APPLICATION_NAME

    @drive.authorization = authorizer.get_credentials("default")
  end

  def upload(local_file:)
    folder_id = ENV.fetch("GOOGLE_DRIVE_FOLDER_ID")

    metadata = Google::Apis::DriveV3::File.new(
      name: File.basename(local_file),
      parents: [folder_id]
    )

    file = @drive.create_file(
      metadata,
      upload_source: local_file,
      content_type: "text/markdown",
      fields: "id,name,parents"
    )

    puts "Uploaded: #{file.name}"
    puts "File ID: #{file.id}"

    file.id
  end

  private

  def authorizer
    client_id =
      Google::Auth::ClientId.from_file(
        "config/oauth_client.json"
      )

    token_store =
      Google::Auth::Stores::FileTokenStore.new(
        file: "config/google_token.yaml"
      )

    Google::Auth::UserAuthorizer.new(
      client_id,
      SCOPE,
      token_store
    )
  end
end