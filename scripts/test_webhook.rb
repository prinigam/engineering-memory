require "dotenv/load"

require_relative "../lib/engineering_memory"

payload = {
  "repository" => {
    "full_name" => "ordwaylabs/ordway"
  },
  "pull_request" => {
    "number" => 26022,
    "merged" => true
  }
}

exit unless payload["pull_request"]["merged"]

EngineeringMemory.new.generate(
  repo: payload["repository"]["full_name"],
  pr_number: payload["pull_request"]["number"]
)