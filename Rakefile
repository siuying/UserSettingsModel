$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  app.name = 'UserSettingsModel'
  app.files += Dir.glob(File.join(app.project_dir, 'vendor/BubbleWrap/lib/**/*.rb'))
end
