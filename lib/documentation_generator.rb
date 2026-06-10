require_relative "file_analyzer"

class DocumentationGenerator
  def generate(context)
    jira = context[:jira]
    github = context[:github]

    analyzer = FileAnalyzer.new
    categorized_files = analyzer.analyze(github[:files])

    <<~MARKDOWN
      # #{jira[:key]} - #{jira[:summary]}

      ## Jira Details

      **Status:** #{jira[:status]}
      **Issue Type:** #{jira[:issue_type]}
      **Reporter:** #{jira[:reporter]}
      **Assignee:** #{jira[:assignee]}

      ## Description

      #{jira[:description]}

      ## Pull Request

      Title: #{github[:pull_request].title}

      #{impacted_components(categorized_files)}

      ## Commits

      #{github[:commits].map { |c| "- #{c.commit.message}" }.join("\n")}

      ## Reviews

      #{github[:reviews].map { |r| "- #{r.user.login}: #{r.state}" }.join("\n")}
    MARKDOWN
  end

  private

  def impacted_components(categorized_files)
    <<~TEXT
      ## Impacted Components

      ### Controllers

      #{categorized_files[:controllers].map(&:filename).join("\n")}

      ### Services

      #{categorized_files[:services].map(&:filename).join("\n")}

      ### Models

      #{categorized_files[:models].map(&:filename).join("\n")}

      ### Interactors

      #{categorized_files[:interactors].map(&:filename).join("\n")}

      ### Specs

      #{categorized_files[:specs].count} spec files updated
    TEXT
  end
end