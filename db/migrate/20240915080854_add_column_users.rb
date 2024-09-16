class AddColumnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :deliver,:boolean 
  end
end
