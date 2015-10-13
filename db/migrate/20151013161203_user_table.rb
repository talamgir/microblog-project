class UserTable < ActiveRecord::Migration
  def change
	create_table :users do |t|
      # t.integer :id
      t.string :name
     end
  end
end
