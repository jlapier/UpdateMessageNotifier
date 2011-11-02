class CreateUpdateMessages < ActiveRecord::Migration
  def change
    create_table :update_messages do |t|
      t.string :subject
      t.text :body
      t.integer :user_id
      t.date :published_on

      t.timestamps
    end
  end
end
