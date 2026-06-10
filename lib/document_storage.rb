class DocumentStorage
  OUTPUT_DIR = "output".freeze

  def save(ticket_key:, content:)
    Dir.mkdir(OUTPUT_DIR) unless Dir.exist?(OUTPUT_DIR)

    path = "#{OUTPUT_DIR}/#{ticket_key}.md"

    File.write(path, content)

    path
  end
end