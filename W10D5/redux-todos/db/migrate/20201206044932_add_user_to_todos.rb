class AddUserToTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :user_id, :integer, null: false
    add_index :todos, :user_id
  end
end
