class AddActivatedUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :activated, :boolean
    add_column :users,  :admin , :boolean
  end
end
