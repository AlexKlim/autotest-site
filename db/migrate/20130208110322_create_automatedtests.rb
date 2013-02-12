class CreateAutomatedtests < ActiveRecord::Migration
  def change
    create_table :automatedtests do |t|
      t.integer :timetable_id
      t.string :name    
      t.timestamps
    end
  end
end
