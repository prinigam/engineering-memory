require "dotenv/load"

require_relative "../lib/google_drive_client"

file_id = GoogleDriveClient.new.upload(
  local_file: "output/FINI-2044.md"
)

puts "Uploaded!"
puts "File ID: #{file_id}"