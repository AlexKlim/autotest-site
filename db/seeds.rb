# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#add tags
Tag.create! name: 'develop'

#add env
%w(prodtest prodstaging lean).each do |env|
  Environment.create! name: env
end

#add tests
%w(smoke smokeForTesters acceptance).each do |test|
  tt = Timetable.create! days: ['']
  Automatedtest.create! name: test, timetable: tt
end