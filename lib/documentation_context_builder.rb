require_relative "github_client"
require_relative "jira_client"

class DocumentationContextBuilder
  def initialize(
    github_client: GithubClient.new,
    jira_client: JiraClient.new
  )
    @github_client = github_client
    @jira_client = jira_client
  end

  def build(ticket_key:, repo:, pr_number:)
    {
      jira: @jira_client.context(ticket_key),
      github: @github_client.fetch_pr_context(
        repo: repo,
        number: pr_number
      )
    }
  end
end