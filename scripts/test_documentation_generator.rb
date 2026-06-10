require "dotenv/load"

require_relative "../lib/documentation_context_builder"
require_relative "../lib/documentation_generator"

context = DocumentationContextBuilder.new.build(
  ticket_key: "FINI-2044",
  repo: "ordwaylabs/ordway",
  pr_number: 26022
)

document = DocumentationGenerator.new.generate(context)

puts document