Gem::Specification.new do |s|
  s.name               = "tomcat_log_parser"
  s.version            = "1.0.0"
  s.license            = 'Apache 2.0'
  s.homepage           = 'http://3wtemplates.com/'

  s.authors = ["Chang Dong"]
  s.date = %q{2014-05-19}
  s.email = %q{gdsdong@gmail.com}
  s.files = ["Rakefile", "lib/tomcat_log_parser.rb"]
  s.summary = 'Tomcat Parser'
  s.description = 'Parser for Tomcat catalina.out and access log'
  s.require_paths = ["lib"]
  s.rubygems_version = %q{2.2.2}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

