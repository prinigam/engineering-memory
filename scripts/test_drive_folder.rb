require "dotenv/load"

require_relative "../lib/google_drive_client"

client = GoogleDriveClient.new

folder = client.drive.get_file(
  ENV.fetch("GOOGLE_DRIVE_FOLDER_ID"),
  fields: "id,name"
)

puts "Folder Found!"
puts "Name: #{folder.name}"
puts "ID: #{folder.id}"