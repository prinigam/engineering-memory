require_relative "patch_extractor"
require_relative "gemini_client"

class DocumentationAnalyzer
  def initialize(ai_client: GeminiClient.new)
    @ai_client = ai_client
  end

  def analyze(context)
    prompt = build_prompt(context)

    @ai_client.generate(prompt)
  end

  private

  def build_prompt(context)
    jira = context[:jira]
    github = context[:github]

    patches = PatchExtractor.new.extract(github[:files])

    <<~PROMPT
      You are an experienced senior software engineer and technical architect.

      Analyze the following Jira ticket and GitHub pull request.

      Generate detailed engineering documentation with the following sections:

      1. Business Context
      2. Problem Statement
      3. Solution Overview
      4. Architecture Impact
      5. Testing Strategy
      6. Future Considerations

      Focus on:
      - Why the change was made
      - What architectural decisions were introduced
      - Key implementation details
      - Impact on existing systems
      - Testing coverage
      - Potential future improvements

      ============================================================
      JIRA
      ============================================================

      Ticket:
      #{jira[:key]}

      Summary:
      #{jira[:summary]}

      Description:
      #{jira[:description]}

      Status:
      #{jira[:status]}

      ============================================================
      PULL REQUEST
      ============================================================

      Title:
      #{github[:pull_request].title}

      Files Changed:
      #{github[:files].map(&:filename).join("\n")}

      ============================================================
      COMMITS
      ============================================================

      #{github[:commits].map { |c| c.commit.message }.join("\n")}

      ============================================================
      PATCH SUMMARY
      ============================================================

      #{patches.first(5).map do |patch|
        <<~PATCH
          File: #{patch[:filename]}

          Additions: #{patch[:additions]}
          Deletions: #{patch[:deletions]}

          #{patch[:patch]&.slice(0, 250)}

        PATCH
      end.join("\n")}
    PROMPT
  end
end