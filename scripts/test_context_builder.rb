require "dotenv/load"

require_relative "../lib/documentation_context_builder"

builder = DocumentationContextBuilder.new

context = builder.build(
  ticket_key: "FINI-2044",
  repo: "ordwaylabs/ordway",
  pr_number: 26022
)

puts "JIRA"
puts "-" * 80
puts context[:jira][:summary]

puts
puts "GITHUB"
puts "-" * 80
puts context[:github][:pull_request].title

puts
puts "FILES"
puts "-" * 80
puts context[:github][:files].count