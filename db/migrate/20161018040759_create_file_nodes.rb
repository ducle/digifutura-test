class CreateFileNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :file_nodes do |t|
      t.integer :owner_id
      t.string :name
      t.string :node_type
      t.string :ancestry
      t.integer :parent_id
      t.integer :position
      t.string :file
      t.string :file_type
      t.integer :file_size

      t.timestamps
    end
    add_column :file_nodes, :ancestry
    add_column :file_nodes, :parent_id
    add_column :file_nodes, :owner_id
    
  end
end
