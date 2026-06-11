require "google/apis/drive_v3"
require "signet/oauth_2/client"

class GoogleDriveClient
  attr_reader :drive

  APPLICATION_NAME = "Engineering Memory"
  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_FILE

  def initialize
    @drive = Google::Apis::DriveV3::DriveService.new
    @drive.client_options.application_name = APPLICATION_NAME

    @drive.authorization = credentials
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

  def credentials
    client = Signet::OAuth2::Client.new(
      token_credential_uri: "https://oauth2.googleapis.com/token",
      client_id: ENV.fetch("OAUTH_CLIENT_ID"),
      client_secret: ENV.fetch("OAUTH_CLIENT_SECRET"),
      refresh_token: ENV.fetch("OAUTH_REFRESH_TOKEN")
    )

    client.fetch_access_token!

    client
  end
end