#!/usr/bin/env ruby

$LOAD_PATH << './lib'
$LOAD_PATH << './../lib'

require 'caelum-git-reports'
require 'date'

workdir = ARGV[0]
if (workdir)
  puts "Git stats for repositories under #{workdir}"

  reporter = CaelumGitReports.new(workdir)
  reporter.extract_all_stats(Date.new - 365)

  for repository in reporter.repository_stats.keys
    puts "[Project #{repository}]"
    for commiter, lines in reporter.repository_stats[repository]
      puts "\t#{commiter}: #{lines}"
    end
    puts
  end

  puts

  for commiter in reporter.commiter_stats.keys
    puts "[Commiter #{commiter}]"
    for repository, lines in reporter.commiter_stats[commiter]
      puts "\t#{repository}: #{lines}"
    end
    puts
  end

end