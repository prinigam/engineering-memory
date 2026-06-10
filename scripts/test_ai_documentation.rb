require "dotenv/load"

require_relative "../lib/documentation_context_builder"
require_relative "../lib/documentation_analyzer"
require_relative "../lib/document_storage"

context = DocumentationContextBuilder.new.build(
  ticket_key: "FINI-2044",
  repo: "ordwaylabs/ordway",
  pr_number: 26022
)

analysis = DocumentationAnalyzer.new.analyze(context)

path = DocumentStorage.new.save(
  ticket_key: context[:jira][:key],
  content: analysis
)

puts "Document saved to: #{path}"

puts "\nRESULT:"
puts analysis