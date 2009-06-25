require 'template'

class HtmlReport

include Template

  def initialize(stats, type, days)
    @stats = stats
    @type = type
    @days = days
  end

  def generate
    report = ''
    report << Template::HEAD.gsub('%TYPE%', @type).gsub('%DAYS%', @days)
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