class AddWeightToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :weight, :decimal, default: 0
  end
end
