Gem::Specification.new do |s|
  s.name               = "Gamsapi"
  s.version            = "0.0.3"
  s.default_executable = "gamsapi"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kamal Shekaran"]
  s.date = %q{2018-11-09}
  s.description = %q{Reading cards from trello and stored in postgresql database and finally write them in flat file}
  s.email = %q{kamal@ifline.com}
  s.files = ["lib/gamsapi.rb", "lib/gamsapi/trello.rb", "lib/gamsapi/default.inc"]  
  s.homepage = %q{http://rubygems.org/gems/gamsapi}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Gamsapi!}  
end

