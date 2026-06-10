require "httparty"
require "json"

class GeminiClient
  MODEL = "gemini-2.5-flash".freeze
  # MODEL = "gemini-2.0-flash".freeze

  def initialize
    @api_key = ENV.fetch("GEMINI_API_KEY")
  end

  def generate(prompt)
    attempts = 0

    begin
      attempts += 1

      response = HTTParty.post(
        "https://generativelanguage.googleapis.com/v1beta/models/#{MODEL}:generateContent?key=#{@api_key}",
        headers: {
          "Content-Type" => "application/json"
        },
        body: {
          contents: [
            {
              parts: [
                {
                  text: prompt
                }
              ]
            }
          ]
        }.to_json
      )

      body = response.parsed_response

      if body["error"]
        raise body["error"]["message"]
      end

      body.dig(
        "candidates",
        0,
        "content",
        "parts",
        0,
        "text"
      )
    rescue StandardError => e
      puts "Gemini request failed (attempt #{attempts}/3): #{e.message}"

      raise if attempts >= 3

      sleep(2 * attempts)
      retry
    end
  end
end