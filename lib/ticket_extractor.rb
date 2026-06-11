class TicketExtractor
  PATTERN = /([A-Z]+-\d+)/

  def extract(github_context)
    pr = github_context[:pull_request]

    candidates = [
      pr.title,
      pr.head.ref
    ]

    candidates.each do |text|
      next if text.nil?

      match = text.match(PATTERN)

      return match[1] if match
    end

    nil
  end
end