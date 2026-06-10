class DocumentationContext
  attr_accessor :jira,
                :pull_request,
                :reviews,
                :commits,
                :files

  def initialize(
    jira: nil,
    pull_request: nil,
    reviews: [],
    commits: [],
    files: []
  )
    @jira = jira
    @pull_request = pull_request
    @reviews = reviews
    @commits = commits
    @files = files
  end
end