require 'template'
require 'time'

class HtmlReport

include Template

  def initialize(stats, title, days)
    @stats = stats
    @title = title
    @days = days
  end

  def generate
    report = ''

    from = (Time.now - @days*60*60*24).strftime("%Y.%m.%d")
    to = Time.now.strftime("%Y.%m.%d")

    report << Template::HEAD.gsub('%TITLE%', @title).gsub("%FROM%", from).gsub('%TO%', to)
    for major in @stats.keys
      report << Template::MAJOR_HEAD.gsub('%MAJOR%', major)
      sum = 0
      for minor, lines in @stats[major]
        report << Template::MINOR.gsub('%MINOR%', minor).gsub('%LINES%', lines.to_s)
        sum += lines
      end
      report << Template::MINOR.gsub('%MINOR%', '.').gsub('%LINES%', sum.to_s)
      report << Template::MAJOR_TAIL
    end
    report << Template::TAIL
  end

end