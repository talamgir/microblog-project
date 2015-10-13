class Tweet < ActiveRecord::Migration
  def change
	create_table :tweets do |t|
		t.text :content
		t.datetime :posted_at
     end
  end
end
