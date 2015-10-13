class Security < ActiveRecord::Migration
  def change
	add_column :users, :security_question, :string
  end
end
