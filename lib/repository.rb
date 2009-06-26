require 'date'
require 'time'

class Repository
  attr_accessor :name, :dir, :url
  attr_reader :commiters, :summary

  def initialize(name, dir)
    @name = name
    @dir = dir
    @delimiter = "#{200.chr}@@@"
  end

  def clone
    `cd #{dir} && git clone #{url} > /dev/null 2>&1`
  end

  def pull
    `cd #{dir} && git pull`
  end

  def extract_log(from = Date.new, to = Date.new)
    start_date = "#{Date.new - from} days ago"
    end_date = "#{Date.new - to} days ago"
    log = `cd #{dir} && git log --since="#{start_date}" --until="#{end_date} days ago" --pretty=tformat:"%n%an" --numstat --ignore-space-change`
    return log
  end

  def extract_log_with_messages(from = Date.new, to = Date.new)
    start_date = "#{Date.new - from} days ago"
    end_date = "#{Date.new - to} days ago"
    log = `cd #{dir} && git log --since="#{start_date}" --until="#{end_date} days ago" --pretty=tformat:"%an%n%at%n%s#{@delimiter}"`
    return log
  end

  def generate_summary(from = Date.new, to = Date.new)
    log = self.extract_log_with_messages(from, to)
    @summary = Hash.new
    for commit in log.split(@delimiter)
      temp = []
      for info in commit.split("\n")
        temp.push info unless info == ""
      end
      @summary[temp[1]] = {:commiter => temp[0], :time => Time.at(temp[1].to_i), :message => temp[2]}
    end
  end

  def calculate_stats(from = Date.new, to = Date.new)
    regexp = Regexp.new('\A((\w+\s?)+)\s*((([\d-]+\s+[\d-]+.*)*\s)*)')
    log = self.extract_log(from, to)
    log[0] = '' unless log == ""

    match = regexp.match(log)
    @commiters = Hash.new
    while !match.nil?
      email = match[1].gsub("\n", "")

      if @commiters[email].nil?
        @commiters[email] = 0
      end

      commit_informations = match[3]
      commit_informations.split("\n")
      for commit_information in commit_informations
        item = commit_information.split(/\s+/)
        @commiters[email] += item[0].to_i + item[1].to_i
      end
      log.gsub!(regexp,"")
      match = regexp.match(log)
    end
  end
end