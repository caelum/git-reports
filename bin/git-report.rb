#!/usr/bin/env ruby

# Load path
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# Requires
require 'reporter'
require 'date'
require 'html_report'
require 'html_summary'
require 'yaml'

# Command line arguments
workdir = ARGV[0]
days = ARGV[1].to_i
max_commits = ARGV[2].to_i
if (max_commits <= 0)
  max_commits = 50
end
if (ARGV[3])
  translations = YAML::load(File.open(ARGV[3]))
else
  translations = {}
end

# Action!
if (workdir and days > 0)
  puts "Git stats for repositories under #{workdir}"

  reporter = Reporter.new(workdir, translations)
  reporter.extract_all_stats(Date.new - days) do |name|
    puts "Checking #{name}..."
  end

  now = Time.now.strftime("%Y.%m.%d")

  # Repository stats
  repository_html = File.new("repositories-#{now}-#{days}.html", "w")
  repository_html.puts HtmlReport.new(reporter.repository_stats, "Statistics for repositories", days).generate
  repository_html.close

  # Committer stats
  committer_html = File.new("committers-#{now}-#{days}.html", "w")
  committer_html.puts HtmlReport.new(reporter.commiter_stats, "Statistics for committers", days).generate
  committer_html.close

  # Commit summary
  summary_html = File.new("summary-#{now}-#{days}.html", "w")
  summary_html.puts HtmlSummary.new(reporter.repository_summaries, "Summary", days, max_commits).generate
  summary_html.close
else
  puts "caelum-git-reports"
  puts "Usage:"
  puts "git-report.rb <path to repositories> <number of days to look back>"
  puts "git-report.rb <path to repositories> <number of days to look back> <number of commits in summary>"
  puts "git-report.rb <path to repositories> <number of days to look back> <number of commits in summary> <yaml file for committer name translation>"
end