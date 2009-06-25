require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'repository'
require 'html_report'

describe "HtmlReport" do

  before :each do
    stats = Hash.new
    stats['Major1'] = Hash.new
    stats['Major1']['Minor1'] = 100
    stats['Major1']['Minor2'] = 200
    stats['Major2'] = Hash.new
    stats['Major2']['Minor2'] = 222
    stats['Major2']['Minor3'] = 333
    @report = HtmlReport.new(stats, "repositories!", "123").generate
    puts @report
  end

  it "should have a title" do
    @report.should include("Statistics for repositories!")
  end

  it "should specify the considered date" do
    @report.should include("For the last 123 days")
  end

  it "should include all majors" do
    @report.should include("Major1")
    @report.should include("Major2")
  end

  it "should include all minors" do
    @report.should include("Minor1")
    @report.should include("Minor2")
    @report.should include("Minor3")
  end

  it "should include the line impact for each minor in each major" do
    @report.should include("100")
    @report.should include("200")
    @report.should include("222")
    @report.should include("333")
  end

  it "should include the sum of all minors for each major" do
    @report.should include("300")
    @report.should include("555")
  end

end
