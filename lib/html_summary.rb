require 'template'
require 'time'

class HtmlSummary

include Template

  def initialize(summaries, title, days)
    @summaries = summaries
    @title = title
    @days = days
    @summary = Hash.new
  end

  def generate
    report = ''

    from = (Time.now - @days*60*60*24).strftime("%Y.%m.%d")
    to = Time.now.strftime("%Y.%m.%d")

    report << Template::HEAD.gsub('%TITLE%', @title).gsub("%FROM%", from).gsub('%TO%', to)
    merge

    for commit in @summary.keys.sort.reverse
      report << Template::COMMIT.gsub("%REPOSITORY%", @summary[commit][:repository] || "nil").
                                 gsub("%MESSAGE%", @summary[commit][:message] || "nil").
                                 gsub("%COMMITER%", @summary[commit][:commiter] || "nil").
                                 gsub("%TIMEDATE%", @summary[commit][:time].to_s || "nil")
    end

    report << Template::TAIL

    return report
  end

  def merge
    timestamps = []
    for repository in @summaries.keys
      for timestamp in @summaries[repository].keys
        timestamps.push timestamp
      end
    end
    timestamps.sort!

    i = 0
    for timestamp in timestamps
      for repository in @summaries.keys
        if (@summaries[repository][timestamp])
          @summary[i] = Hash.new
          @summary[i][:repository] = repository
          @summary[i][:message] = @summaries[repository][timestamp][:message]
          @summary[i][:commiter] = @summaries[repository][timestamp][:commiter]
          @summary[i][:time] = @summaries[repository][timestamp][:time]
          i = i + 1
        end
      end
    end
  end

end