class Automatedtest < ActiveRecord::Base
  attr_accessible :name, :timetable

  belongs_to :timetable

  validates_uniqueness_of :name
end
