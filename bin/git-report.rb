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
  HtmlReport.new(reporter.repository_stats, repository_html)
  repository_html.close

  commiter_html = File.new("commiters.html", "w")
  HtmlReport.new(reporter.commiter_stats, commiter_html)
  commiter_html.close

end