require "dotenv/load"

require_relative "../lib/engineering_memory"

EngineeringMemory.new.generate(
  repo: "ordwaylabs/ordway",
  pr_number: 26022
)