class HtmlReport

  def initialize(stats, file)
    for major in stats.keys
    file.puts "[#{major}]"
    for minor, lines in stats[major]
      file.puts "\t#{minor}: #{lines}"
    end
    file.puts
  end

  end

end