#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

AutomatedTestSite::Application.load_tasks


namespace :add do
  task env: :environment do
    %w(prodtest prodstaging lean).each do |env|
      Environment.create! name: env
    end
  end

  task tests: :environment do
    %w(smoke smokeForTesters acceptance).each do |test|
      tt = Timetable.create! days: ['']
      Automatedtest.create! name: test, timetable: tt
    end
  end

  task tags: :environment do
    %w(develop release_175 release_174 release_173 release_171).each do |tag|
      Tag.create! name: tag
    end
  end

end

task update_test: :environment do
  path = File.expand_path("#{Autotest::CONFIG.auto_test}/features/functionality/")
  folders = Dir[path + '/*'].map { |a| File.basename(a).split('_features')[0] }

  folders.each do |name|
    unless Automatedtest.all.map(&:name).include? name
      tt = Timetable.create! days: ['']
      Automatedtest.create! name: name, timetable: tt
    end
  end
end

namespace :auto_test do

  task run: :environment do
    system("cd #{Autotest::CONFIG.auto_test} && rake auto:test P=#{ENV['P']} HOST=#{ENV['HOST']} &")  
  end

  task update_code: :environment do
    system("cd #{Autotest::CONFIG.auto_test} && hg pull --rebase && hg update")
  end

  task create_report: :environment do
    folder = "%s/%s/%s" % [Rails.root, Autotest::CONFIG.test_folder, "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}"]    
    Dir.mkdir folder
    path = File.expand_path(Autotest::CONFIG.test_folder)
    Dir.new(path).each { |x|
      if x[/.*\.erb$/] != nil
        FileUtils.cp("#{path}/#{x}", folder)
      end
    }
  end

  task remove_tests: :environment do
    system("cd #{Autotest::CONFIG.auto_test} && find -iname '*.html' -delete && find -iname '*.erb' -delete")
  end

  task send_mail: :environment do
    system("cd ~/projects/sh-scripts && ./send_mail.sh #{ENV['HOST']")
  end
  
end
