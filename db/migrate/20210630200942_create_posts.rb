class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :slug, index: true
      t.boolean :published, null: false, default: false
      t.references :parent, foreign_key: { to_table: :posts }
      t.integer :position

      t.timestamps
    end
  end
end
