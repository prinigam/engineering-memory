require "dotenv/load"
require_relative "../lib/github_client"

client = GithubClient.new

context = client.fetch_pr_context(
  repo: "ordwaylabs/ordway",
  number: 26022
)

puts "Title: #{context[:pull_request].title}"
puts "Files: #{context[:files].count}"
puts "Reviews: #{context[:reviews].count}"
puts "Commits: #{context[:commits].count}"