# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{git-reports}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Caue Guerra", "Pedro Matiello"]
  s.date = %q{2009-07-13}
  s.default_executable = %q{git-report.rb}
  s.email = %q{caue.guerra@gmail.com}
  s.executables = ["git-report.rb"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/git-report.rb",
     "git-reports.gemspec",
     "lib/html_report.rb",
     "lib/html_summary.rb",
     "lib/reporter.rb",
     "lib/repository.rb",
     "lib/template.rb",
     "spec/html_report_spec.rb",
     "spec/html_summary_spec.rb",
     "spec/reporter_spec.rb",
     "spec/repository_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/caelum/git-reports}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Git report tool}
  s.test_files = [
    "spec/reporter_spec.rb",
     "spec/repository_spec.rb",
     "spec/spec_helper.rb",
     "spec/html_report_spec.rb",
     "spec/html_summary_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
