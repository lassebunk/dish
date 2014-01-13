unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  Dir[File.join(File.dirname(__FILE__), "**/*.rb")].each do |file|
    app.files.unshift(file) unless file =~ /\/(ext|motion)\.rb$/ # Exclude ext.rb because it uses `require`
  end
end