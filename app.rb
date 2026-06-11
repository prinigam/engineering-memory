begin
  require "dotenv/load"
rescue LoadError
end

require "json"
require "sinatra"

require_relative "lib/engineering_memory"

get "/" do
  "Engineering Memory Running"
end

post "/github" do
  payload = JSON.parse(request.body.read)

  return 200 unless payload["pull_request"]
  return 200 unless payload["pull_request"]["merged"]

  Thread.new do
    begin
      EngineeringMemory.new.generate(
        repo: payload["repository"]["full_name"],
        pr_number: payload["pull_request"]["number"]
      )
    rescue => e
      puts "Webhook processing failed: #{e.message}"
      puts e.backtrace
    end
  end

  status 200
end