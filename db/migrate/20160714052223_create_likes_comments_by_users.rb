class CreateLikesCommentsByUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :likes_comments_by_users do |t|
      t.boolean :is_possitive
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
