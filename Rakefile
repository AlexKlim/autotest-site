#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

AutomatedTestSite::Application.load_tasks

namespace :update do

  task tags: [:environment, :code] do
    path = File.expand_path("#{Autotest::CONFIG.auto_test}/.hgtags")
    Tag.delete_all
    Tag.create! name: 'develop'

    file = []
    File.open(path).each_line do |line|
      file << line
    end

    file.reverse.each do |line|
      tag = line[/(lean|release_).*/]
      unless tag.nil?
        Tag.create! name: tag
      end
    end
  end

  task tests: :environment do
    path = File.expand_path("#{Autotest::CONFIG.auto_test}/features/functionality/")
    folders = Dir[path + '/*'].map { |a| File.basename(a).split('_features')[0] }

    automatedtests = Automatedtest.all.map(&:name)
    folders.each do |name|
      unless automatedtests.include? name
        tt = Timetable.create! days: ['']
        Automatedtest.create! name: name, timetable: tt
      end
    end
  end

  task code: :environment do
    system("cd #{Autotest::CONFIG.auto_test} && hg pull --rebase && hg update")
  end

end

namespace :auto_test do

  task run: :environment do
    run_task = (ENV['P'] == 'smokeForTesters' ? 'smoke_for_testers' : "cucumber_test P=#{ENV['P']}")
    system("cd #{Autotest::CONFIG.auto_test} && rake #{run_task} HOST=#{ENV['HOST']}")
  end

  task create_report: :environment do
    folder = "%s/%s/%s" % [Rails.root, Autotest::CONFIG.test_folder, "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}"]
    Dir.mkdir folder
    path = File.expand_path(Autotest::CONFIG.auto_test)
    Dir.new(path).each do |x|
      if x[/.*\.erb$/] != nil
        FileUtils.cp("#{path}/#{x}", folder)
      end
    end
  end

  task remove_tests: :environment do
    system("cd #{Autotest::CONFIG.auto_test} && find -iname '*.html' -delete && find -iname '*.erb' -delete")
  end

  task send_mail: :environment do
    UserMailer.send_email.deliver
  end

  task separate_test: [:environment, :run] do
    UserMailer.send_separate_report(ENV['HOST'], ENV['P']).deliver
  end

end

task start_delayed: :environment do
  system "RAILS_ENV=production script/delayed_job start"
end
