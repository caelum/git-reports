require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'repository'
require 'html_summary'
require 'time'

describe "HtmlSummary" do

  before :each do
    stats = Hash.new
    stats['Repo1'] = Hash.new
    stats['Repo1']['1'] = {:commiter => "Commiter 1", :time => "Time 1", :message => "Message 1"}
    stats['Repo1']['3'] = {:commiter => "Commiter 2", :time => "Time 3", :message => "Message 3"}
    stats['Repo1']['5'] = {:commiter => "Commiter 3", :time => "Time 5", :message => "Message 5"}
    stats['Repo2'] = Hash.new
    stats['Repo2']['2'] = {:commiter => "Commiter 3", :time => "Time 2", :message => "Message 2"}
    stats['Repo2']['4'] = {:commiter => "Commiter 3", :time => "Time 4", :message => "Message 4"}
    @report = HtmlSummary.new(stats, "Summary!", 123, 4).generate
  end

  it "should have a title" do
    @report.should include("Summary!")
  end

  it "should specify the considered date" do
    from = (Time.now - 123*60*60*24).strftime("%Y.%m.%d")
    to = Time.now.strftime("%Y.%m.%d")
    @report.should include("From #{from} to #{to}")
  end

  it "should include the repository name" do
    @report.should include("Repo1")
    @report.should include("Repo2")
  end

  it "should include the commit message" do
    @report.should_not include("Message 1")
    @report.should include("Message 2")
    @report.should include("Message 3")
    @report.should include("Message 4")
    @report.should include("Message 5")
  end

  it "should include commiter's name" do
    @report.should_not include("Commiter 1")
    @report.should include("Commiter 2")
    @report.should include("Commiter 3")
  end

  it "should include the time and date for each commit" do
    @report.should_not include("Time 1")
    @report.should include("Time 2")
    @report.should include("Time 3")
    @report.should include("Time 4")
    @report.should include("Time 5")
  end

end
