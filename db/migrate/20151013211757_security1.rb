class Security1 < ActiveRecord::Migration
  def change
	add_column :users, :security_answer, :string
  end
end
