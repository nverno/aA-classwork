class AddTimestampsToSessions < ActiveRecord::Migration[5.2]
  def change
    change_table :sessions do |t|
      t.timestamps
    end
  end
end
