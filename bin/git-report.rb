#!/usr/bin/env ruby

$LOAD_PATH << './lib'
$LOAD_PATH << './../lib'

require 'caelum-git-reports'
require 'date'
require 'html_report'

workdir = ARGV[0]
if (workdir)
  puts "Git stats for repositories under #{workdir}"

  reporter = CaelumGitReports.new(workdir)
  reporter.extract_all_stats(Date.new - 365)

  repository_html = File.new("repositories.html", "w")
  repository_html.puts HtmlReport.new(reporter.repository_stats, "repositories").generate
  repository_html.close

  commiter_html = File.new("commiters.html", "w")
  commiter_html.puts HtmlReport.new(reporter.commiter_stats, "commiters").generate
  commiter_html.close

end