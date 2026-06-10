require "dotenv/load"
require "httparty"
require "json"

response = HTTParty.post(
  "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=#{ENV.fetch('GEMINI_API_KEY')}",
  headers: {
    "Content-Type" => "application/json"
  },
  body: {
    contents: [
      {
        parts: [
          {
            text: "Explain Ruby in one sentence."
          }
        ]
      }
    ]
  }.to_json
)

puts JSON.pretty_generate(response.parsed_response)