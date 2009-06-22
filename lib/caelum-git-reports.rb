require 'repository'

class CaelumGitReports
  attr_accessor :work_dir
  attr_reader :repositories
  attr_accessor :stats
  
  def initialize(work_dir)
    @work_dir = work_dir
    @repositories = Hash.new
    @stats = Hash.new
    discover_repositories
    initialize_repositories
  end
  
  def extract_stats(repository_name, from = Date.new, to = Date.new)
    @stats[repository_name] = Hash.new
    repository = @repositories[repository_name]
    repository.pull
    repository.log(from, to)
    repository.calculate_stats
    for commiter in repository.commiters.keys
      @stats[repository_name][commiter] = repository.commiters[commiter]
    end
  end
  
  def extract_all_stats(from = Date.new, to = Date.new)
    for repository in @repositories.values
      extract_stats(repository.name, from, to)
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