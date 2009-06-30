# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{caelum-git-reports}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Caue Guerra", "Pedro Matiello"]
  s.date = %q{2009-06-22}
  s.email = %q{caue.guerra@caelum.com.br}
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
     "lib/caelum-git-reports.rb",
     "lib/repository.rb",
     "spec/caelum-git-reports_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/caelum/caelum-git-reports}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{this project aims to extract statistics from GitHub commits}
  s.test_files = [
    "spec/caelum-git-reports_spec.rb",
     "spec/spec_helper.rb"
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
