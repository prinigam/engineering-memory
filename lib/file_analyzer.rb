class FileAnalyzer
  def analyze(files)
    {
      controllers: files.select { |f| f.filename.start_with?("app/controllers") },
      services: files.select { |f| f.filename.start_with?("app/services") },
      models: files.select { |f| f.filename.start_with?("app/models") },
      interactors: files.select { |f| f.filename.start_with?("app/interactors") },
      specs: files.select { |f| f.filename.start_with?("spec/") }
    }
  end

  def summary(files)
    analysis = analyze(files)

    {
      controllers: analysis[:controllers].count,
      services: analysis[:services].count,
      models: analysis[:models].count,
      interactors: analysis[:interactors].count,
      specs: analysis[:specs].count
    }
  end
end