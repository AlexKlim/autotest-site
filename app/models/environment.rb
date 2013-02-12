class Environment < ActiveRecord::Base
  has_many :tets
  attr_accessible :name, :current

  scope :current, lambda {where current: true}
end
