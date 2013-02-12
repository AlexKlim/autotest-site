class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.string :value
      t.string :days
    end
  end
end
