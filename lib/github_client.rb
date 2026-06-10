require "octokit"

class GithubClient
  def initialize
    @client = Octokit::Client.new(
      access_token: ENV.fetch("GITHUB_TOKEN")
    )
  end

  def fetch_pr_context(repo:, number:)
    {
      pull_request: pull_request(repo:, number:),
      files: files(repo:, number:),
      reviews: reviews(repo:, number:),
      commits: commits(repo:, number:)
    }
  end

  private

  def pull_request(repo:, number:)
    @client.pull_request(repo, number)
  end

  def files(repo:, number:)
    @client.pull_request_files(repo, number)
  end

  def reviews(repo:, number:)
    @client.pull_request_reviews(repo, number)
  end

  def commits(repo:, number:)
    @client.pull_request_commits(repo, number)
  end
end