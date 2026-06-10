require_relative "jira_description_parser"
require "httparty"

class JiraClient
  def initialize
    @base_url = ENV.fetch("JIRA_BASE_URL")
    @email = ENV.fetch("JIRA_EMAIL")
    @api_token = ENV.fetch("JIRA_API_TOKEN")
  end

  def issue(ticket_key)
    response = HTTParty.get(
      "#{@base_url}/rest/api/3/issue/#{ticket_key}",
      basic_auth: {
        username: @email,
        password: @api_token
      },
      headers: {
        "Accept" => "application/json"
      }
    )

    raise "Failed to fetch Jira issue: #{response.code}" unless response.success?

    response.parsed_response
  end

  def context(ticket_key)
    issue = self.issue(ticket_key)

    {
      key: issue["key"],
      summary: issue.dig("fields", "summary"),
      description: JiraDescriptionParser.parse(
        issue.dig("fields", "description")
      ),
      status: issue.dig("fields", "status", "name"),
      issue_type: issue.dig("fields", "issuetype", "name"),
      reporter: issue.dig("fields", "reporter", "displayName"),
      assignee: issue.dig("fields", "assignee", "displayName")
    }
  end
end