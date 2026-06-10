class JiraDescriptionParser
  def self.parse(description)
    return "" if description.nil?

    extract_text(description).join("\n")
  end

  def self.extract_text(node)
    return [] if node.nil?

    if node.is_a?(Hash)
      results = []

      results << node["text"] if node["text"]

      if node["content"]
        node["content"].each do |child|
          results.concat(extract_text(child))
        end
      end

      results
    elsif node.is_a?(Array)
      node.flat_map { |item| extract_text(item) }
    else
      []
    end
  end
end