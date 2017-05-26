class TagUser < ActiveRecord::Migration[5.0]
  def change
    create_table (:tag_users) do |t|
      t.references :user, foreing_key: true
      t.references :tag, foreing_key: true

      t.timestamps

    end
    add_index :tag_users, [:user_id,:tag_id], unique: true
  end
end
