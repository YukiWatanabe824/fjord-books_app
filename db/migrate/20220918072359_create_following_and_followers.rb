class CreateFollowingAndFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :following_and_followers do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :following_and_followers, :follower_id
    add_index :following_and_followers, :followed_id
    add_index :following_and_followers, [:follower_id, :followed_id], unique: true 
  end
end
