class AddFileNodeUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :file_nodes, :users
  end
end
