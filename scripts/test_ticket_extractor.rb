require "dotenv/load"

require_relative "../lib/github_client"
require_relative "../lib/ticket_extractor"

github = GithubClient.new.fetch_pr_context(
  repo: "ordwaylabs/ordway",
  number: 26022
)

ticket =
  TicketExtractor.new.extract(github)

puts ticket