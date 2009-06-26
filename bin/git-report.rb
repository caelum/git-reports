#!/usr/bin/env ruby

$LOAD_PATH << './lib'
$LOAD_PATH << './../lib'

require 'caelum-git-reports'
require 'date'
require 'html_report'

workdir = ARGV[0]
days = ARGV[1].to_i
if (workdir and days)
  puts "Git stats for repositories under #{workdir}"

  reporter = CaelumGitReports.new(workdir)
  reporter.extract_all_stats(Date.new - days) do |name|
    puts "Checking #{name}..."
  end

  repository_html = File.new("repositories.html", "w")
  repository_html.puts HtmlReport.new(reporter.repository_stats, "repositories", days).generate
  repository_html.close

  commiter_html = File.new("commiters.html", "w")
  commiter_html.puts HtmlReport.new(reporter.commiter_stats, "commiters", days).generate
  commiter_html.close

end