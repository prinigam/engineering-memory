require "googleauth"
require "googleauth/stores/file_token_store"
require "google/apis/drive_v3"
require "fileutils"

OOB_URI = "urn:ietf:wg:oauth:2.0:oob"
APPLICATION_NAME = "Engineering Memory"

SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_FILE

FileUtils.mkdir_p("config")

client_id =
  Google::Auth::ClientId.from_file(
    "config/oauth_client.json"
  )

token_store =
  Google::Auth::Stores::FileTokenStore.new(
    file: "config/google_token.yaml"
  )

authorizer =
  Google::Auth::UserAuthorizer.new(
    client_id,
    SCOPE,
    token_store
  )

user_id = "default"

credentials =
  authorizer.get_credentials(user_id)

if credentials.nil?
  url = authorizer.get_authorization_url(
    base_url: OOB_URI
  )

  puts "Open this URL in your browser:"
  puts url
  puts
  print "Enter authorization code: "

  code = gets.chomp

  credentials =
    authorizer.get_and_store_credentials_from_code(
      user_id: user_id,
      code: code,
      base_url: OOB_URI
    )
end

puts "OAuth setup complete!"