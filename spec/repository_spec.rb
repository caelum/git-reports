require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'repository'

describe "Repository" do

  it "should calculate stats" do

    class Repository
      def log
        @log = "
User1

5 3 File1
2 2 File2

User1

1 1 File1
2 2 File3

User2

7 0 File1
0 3 File2
"
      end
    end

    repository = Repository.new("SampleRepository","ArbitraryDirectory")
    repository.log
    repository.calculate_stats
    repository.commiters['User1'].should be(18)
    repository.commiters['User2'].should be(10)

  end

end
