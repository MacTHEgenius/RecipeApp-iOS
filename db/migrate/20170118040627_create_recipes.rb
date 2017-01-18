class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name, default: ""
      t.integer :cooking_duration, default: 0
      t.integer :baking_duration, default: 0
      t.integer :author_id

      t.timestamps null: false
    end
    add_index :recipes, :author_id
  end
end
