class Environment < ActiveRecord::Migration
  def up
    create_table :environments do |t|
      t.string :name
      t.boolean :current, default: true
    end
  end

  def down
    drop_table :environments
  end
end
