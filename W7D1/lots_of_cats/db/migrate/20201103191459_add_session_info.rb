class AddSessionInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :http_user_agent, :string
    add_column :sessions, :http_host, :string
  end
end
