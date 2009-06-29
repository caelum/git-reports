#!/usr/bin/env ruby

$LOAD_PATH << './lib'
$LOAD_PATH << './../lib'

require 'reporter'
require 'date'
require 'html_report'
require 'html_summary'

workdir = ARGV[0]
days = ARGV[1].to_i
max_commits = ARGV[2].to_i
if (max_commits == 0)
  max_commits = 50
end

if (workdir and days)
  puts "Git stats for repositories under #{workdir}"

  reporter = Reporter.new(workdir)
  reporter.extract_all_stats(Date.new - days) do |name|
    puts "Checking #{name}..."
  end

  now = Time.now.strftime("%Y.%m.%d")

  repository_html = File.new("repositories-#{now}-#{days}.html", "w")
  repository_html.puts HtmlReport.new(reporter.repository_stats, "Statistics for repositories", days).generate
  repository_html.close

  commiter_html = File.new("commiters-#{now}-#{days}.html", "w")
  commiter_html.puts HtmlReport.new(reporter.commiter_stats, "Statistics for commiters", days).generate
  commiter_html.close

  summary_html = File.new("summary-#{now}-#{days}.html", "w")
  summary_html.puts HtmlSummary.new(reporter.repository_summaries, "Summary", days, max_commits).generate
  summary_html.close

end