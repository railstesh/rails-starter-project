class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :slug
      t.text :description
      t.integer :post_id, index: true
      t.references :user

      t.timestamps
    end
  end
end
