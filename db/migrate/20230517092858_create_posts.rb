class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :image_data

      t.timestamps
    end
  end
end
