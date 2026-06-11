require_relative "github_client"
require_relative "jira_client"
require_relative "ticket_extractor"
require_relative "documentation_context_builder"
require_relative "documentation_analyzer"
require_relative "document_storage"
require_relative "google_drive_client"

class EngineeringMemory
  def generate(repo:, pr_number:)
    puts "Fetching GitHub PR..."

    github_context =
      GithubClient.new.fetch_pr_context(
        repo: repo,
        number: pr_number
      )

    puts "Extracting Jira ticket..."

    ticket_key =
      TicketExtractor.new.extract(
        github_context
      )

    raise "Could not determine Jira ticket" if ticket_key.nil?

    puts "Found ticket: #{ticket_key}"

    puts "Building context..."

    context =
      DocumentationContextBuilder.new.build(
        ticket_key: ticket_key,
        repo: repo,
        pr_number: pr_number
      )

    puts "Generating documentation..."

    document =
      DocumentationAnalyzer.new.analyze(
        context
      )

    puts "Saving markdown..."

    path =
      DocumentStorage.new.save(
        ticket_key: ticket_key,
        content: document
      )

    puts "Uploading to Google Drive..."

    file_id =
      GoogleDriveClient.new.upload(
        local_file: path
      )

    puts
    puts "Done!"
    puts "Ticket: #{ticket_key}"
    puts "Drive File ID: #{file_id}"

    file_id
  end
end