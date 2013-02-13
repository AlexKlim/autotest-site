class Automatedtest < ActiveRecord::Base
  attr_accessible :name, :timetable

  belongs_to :timetable, dependent: :destroy

  validates_uniqueness_of :name
end
