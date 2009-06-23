require 'date'

class Repository
  attr_accessor :name, :dir, :url
  attr_reader :commiters

  def initialize(name, dir)
    @name = name
    @dir = dir
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