class Timetable < ActiveRecord::Base
  attr_accessible :value, :days
  serialize :days

  has_one :automatedtest

  def self.for(var)
    find_or_create_by_var(var)
  end

  def set=(value)
     update_attributes(value: value)
  end

  def self.send_cron_later
    delay.update_cron
  end

  private
  def self.update_cron
    system 'bundle exec whenever --update-crontab AutomatedTestSite'
  end
end
