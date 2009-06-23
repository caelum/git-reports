require 'repository'
require 'date'

class CaelumGitReports
  attr_accessor :work_dir
  attr_reader :repositories
  attr_accessor :repository_stats, :commiter_stats

  def initialize(work_dir)
    @work_dir = work_dir
    @repositories = Hash.new
    @repository_stats = Hash.new
    @commiter_stats = Hash.new
    discover_repositories
    initialize_repositories
  end

  def extract_stats(repository_name, from = Date.new, to = Date.new)
    @repository_stats[repository_name] = Hash.new
    repository = @repositories[repository_name]
    repository.pull
    repository.calculate_stats(from, to)
    for commiter in repository.commiters.keys
      @repository_stats[repository_name][commiter] = repository.commiters[commiter]
    end
    extract_stats_for_commiters(repository_name)
  end

  def extract_all_stats(from = Date.new, to = Date.new)
    for repository in @repositories.values
      extract_stats(repository.name, from, to)
    end
  end

  private
  def extract_stats_for_commiters(repository_name)
    for commiter, lines in @repository_stats[repository_name]
      @commiter_stats[commiter] = Hash.new unless @commiter_stats[commiter].instance_of? Hash
      @commiter_stats[commiter][repository_name] = lines
    end
  end

  private
  def discover_repositories
    @repositories_names = `cd #{work_dir} && ls`.split("\n")
  end

  def initialize_repositories
    for repository_name in @repositories_names
      repository = Repository.new(repository_name, @work_dir + "/#{repository_name}")
      @repositories[repository_name] = repository
    end
  end
end