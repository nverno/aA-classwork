class CreateTodos < ActiveRecord::Migration[5.2] # rubocop:todo Style/Documentation
  def change
    create_table :todos do |t|
      t.string  :title, null: false
      t.string  :body, null: false
      t.boolean :done, default: false

      t.timestamps
    end

    add_index :todos, :title
  end
end
