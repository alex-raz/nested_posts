class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.integer :position
      t.string :name
      t.timestamps
    end
  end
end
