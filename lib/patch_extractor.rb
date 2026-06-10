class PatchExtractor
  def extract(files)
    files.map do |file|
      {
        filename: file.filename,
        additions: file.additions,
        deletions: file.deletions,
        patch: file.patch
      }
    end
  end
end