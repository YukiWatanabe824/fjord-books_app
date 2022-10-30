class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :commentable, polymorphic: true

      t.timestamps
    end
    add_index :comments, [:user_id, :created_at]
  end
end
